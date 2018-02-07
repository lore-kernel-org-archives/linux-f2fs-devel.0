From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 5/5] fsck.f2fs: reconnect unreachable
 files to lost+found
Date: Wed, 7 Feb 2018 18:01:40 +0800
Message-ID: <49dc523a-c44b-ef70-8aa9-2600f92d5f79@huawei.com>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-6-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ejMYP-0003uv-Mg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 10:02:13 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejMYJ-0002P8-UR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 10:02:13 +0000
In-Reply-To: <20180206043125.134191-6-shengyong1@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net


On 2018/2/6 12:31, Sheng Yong wrote:
> This patch introduces lost+found feature to fsck. If a file is found
> unreachable by fsck. Fsck tries to reconnect the file to lost+found
> directory:
>    1. Scan all unreachable file inodes, ignore non-inodes ones and
>       directories.
>    2. Check them and fix incorrupted data to make sure filesystem
>       metadata (mainly counters and main/nat bitmap) are all consistent.
>    3. Reconnect these files to lost+found. If lost+found does not exist,
>       create it first. During reconnecting, expand lost+found's dentry
>       block automatically. Reconnected files are renamed after its ino
>       number.
>    4. If reconnect fails drop the node and restore filesystem metadata.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>   fsck/dir.c   |  19 ++-
>   fsck/fsck.c  | 376 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   fsck/fsck.h  |   3 +
>   fsck/mount.c |   2 +
>   4 files changed, 397 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index b2ea18f..567a4e9 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -176,6 +176,23 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
>   	return 0;
>   }
>   
> +/* return ino if file exists, otherwise return 0 */
> +nid_t f2fs_lookup(struct f2fs_sb_info *sbi, struct f2fs_node *dir,
> +				u8 *name, int len)
> +{
> +	int err;
> +	struct dentry de = {
> +		.name = name,
> +		.len = len,
> +	};
> +
> +	err = f2fs_find_entry(sbi, dir, &de);
> +	if (err == 1)
> +		return de.ino;
> +	else
> +		return 0;
> +}
> +
>   static void f2fs_update_dentry(nid_t ino, int file_type,
>   		struct f2fs_dentry_ptr *d,
>   		const unsigned char *name, int len, f2fs_hash_t name_hash,
> @@ -199,7 +216,7 @@ static void f2fs_update_dentry(nid_t ino, int file_type,
>   /*
>    * f2fs_add_link - Add a new file(dir) to parent dir.
>    */
> -static int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
> +int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
>   			const unsigned char *name, int name_len, nid_t ino,
>   			int file_type, block_t p_blkaddr, int inc_link)
>   {
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index fcaab14..81e1145 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -10,6 +10,7 @@
>    */
>   #include "fsck.h"
>   #include "quotaio.h"
> +#include <time.h>
>   
>   char *tree_mark;
>   uint32_t tree_mark_size = 256;
> @@ -43,6 +44,14 @@ static inline int f2fs_test_main_bitmap(struct f2fs_sb_info *sbi, u32 blk)
>   						fsck->main_area_bitmap);
>   }
>   
> +static inline int f2fs_clear_main_bitmap(struct f2fs_sb_info *sbi, u32 blk)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +
> +	return f2fs_clear_bit(BLKOFF_FROM_MAIN(sbi, blk),
> +						fsck->main_area_bitmap);
> +}
> +
>   static inline int f2fs_test_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
>   {
>   	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> @@ -448,9 +457,11 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
>   
>   	/* workaround to fix later */
>   	if (ftype != F2FS_FT_ORPHAN ||
> -			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0)
> +			f2fs_test_bit(nid, fsck->nat_area_bitmap) != 0) {
>   		f2fs_clear_bit(nid, fsck->nat_area_bitmap);
> -	else
> +		/* avoid reusing nid when reconnecting files */
> +		f2fs_set_bit(nid, NM_I(sbi)->nid_bitmap);
> +	} else
>   		ASSERT_MSG("orphan or xattr nid is duplicated [0x%x]\n",
>   				nid);
>   
> @@ -2041,6 +2052,362 @@ int check_sit_types(struct f2fs_sb_info *sbi)
>   	return err;
>   }
>   
> +static struct f2fs_node *fsck_get_lpf(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_node *node;
> +	struct node_info ni;
> +	nid_t lpf_ino;
> +	int err;
> +
> +	/* read root inode first */
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +	get_node_info(sbi, F2FS_ROOT_INO(sbi), &ni);
> +	err = dev_read_block(node, ni.blk_addr);
> +	ASSERT(err >= 0);
> +
> +	/* lookup lost+found in root directory */
> +	lpf_ino = f2fs_lookup(sbi, node, (u8 *) LPF, strlen(LPF));

The 4th parameter should be namelen but not strlen(LPF).

> +	if (lpf_ino) { /* found */
> +		get_node_info(sbi, lpf_ino, &ni);
> +		err = dev_read_block(node, ni.blk_addr);
> +		ASSERT(err >= 0);
> +		DBG(1, "Found lost+found 0x%x at blkaddr [0x%x]\n",
> +		    lpf_ino, ni.blk_addr);
> +		if (!S_ISDIR(le16_to_cpu(node->i.i_mode))) {
> +			ASSERT_MSG("lost+found is not directory [0%o]\n",
> +				   le16_to_cpu(node->i.i_mode));
> +			/* FIXME: give up? */
> +			goto out;
> +		}
> +	} else { /* not found, create it */
> +		struct dentry de;
> +
> +		memset(&de, 0, sizeof(de));
> +		de.name = (u8 *) LPF;
> +		de.len = strlen(LPF);
> +		de.mode = 0x41c0;
> +		de.pino = F2FS_ROOT_INO(sbi),
> +		de.file_type = F2FS_FT_DIR,
> +		de.uid = getuid();
> +		de.gid = getgid();
> +		de.mtime = time(NULL);
> +
> +		err = f2fs_mkdir(sbi, &de);
> +		if (err) {
> +			ASSERT_MSG("Failed create lost+found");
> +			goto out;
> +		}
> +
> +		get_node_info(sbi, de.ino, &ni);
> +		err = dev_read_block(node, ni.blk_addr);
> +		ASSERT(err >= 0);
> +		DBG(1, "Create lost+found 0x%x at blkaddr [0x%x]\n",
> +		    de.ino, ni.blk_addr);
> +	}
> +
> +	c.lpf_ino = le32_to_cpu(node->footer.ino);
> +	return node;
> +out:
> +	free(node);
> +	return NULL;
> +}
> +
> +static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
> +				  struct f2fs_node *lpf,
> +				  struct f2fs_node *fnode)
> +{
> +	char name[80];
> +	size_t namelen;
> +	nid_t ino = le32_to_cpu(fnode->footer.ino);
> +	struct node_info ni;
> +	int ret;
> +
> +	namelen = snprintf(name, 80, "%u", ino);
> +	if (namelen >= 80)
> +		/* ignore terminating '\0', should never happen */
> +		namelen = 79;
> +
> +	if (f2fs_lookup(sbi, lpf, (u8 *) name, strlen(LPF))) {
> +		ASSERT_MSG("Name %s already exist in lost+found", name);
> +		return -EEXIST;
> +	}
> +
> +	get_node_info(sbi, le32_to_cpu(lpf->footer.ino), &ni);
> +	ret = f2fs_add_link(sbi, lpf, (unsigned char *)name, namelen,
> +			    ino, F2FS_FT_REG_FILE, ni.blk_addr, 0);
> +	if (ret) {
> +		ASSERT_MSG("Failed to add inode [0x%x] to lost+found", ino);
> +		return -EINVAL;
> +	}
> +
> +	/* update fnode */
> +	memcpy(fnode->i.i_name, name, namelen);
> +	fnode->i.i_namelen = cpu_to_le32(namelen);
> +	fnode->i.i_pino = c.lpf_ino;
> +	get_node_info(sbi, le32_to_cpu(fnode->footer.ino), &ni);
> +	ret = dev_write_block(fnode, ni.blk_addr);
> +	ASSERT(ret >= 0);
> +
> +	DBG(1, "Reconnect inode [0x%x] to lost+found\n", ino);
> +	return 0;
> +}
> +
> +static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
> +					     nid_t nid)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	struct f2fs_node *node;
> +	struct node_info ni;
> +	u32 addr;
> +	int i, err;
> +
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +
> +	get_node_info(sbi, nid, &ni);
> +	err = dev_read_block(node, ni.blk_addr);
> +	ASSERT(err >= 0);
> +
> +	fsck->chk.valid_node_cnt--;
> +	fsck->chk.valid_blk_cnt--;
> +	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +
> +	for (i = 0; i < ADDRS_PER_BLOCK; i++) {
> +		addr = le32_to_cpu(node->dn.addr[i]);
> +		if (!addr)
> +			continue;
> +		fsck->chk.valid_blk_cnt--;
> +		if (addr == NEW_ADDR)
> +			continue;
> +		f2fs_clear_main_bitmap(sbi, addr);
> +	}
> +}
> +
> +static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
> +					      nid_t nid)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	struct f2fs_node *node;
> +	struct node_info ni;
> +	nid_t tmp;
> +	int i, err;
> +
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +
> +	get_node_info(sbi, nid, &ni);
> +	err = dev_read_block(node, ni.blk_addr);
> +	ASSERT(err >= 0);
> +
> +	fsck->chk.valid_node_cnt--;
> +	fsck->chk.valid_blk_cnt--;
> +	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +
> +	for (i = 0; i < NIDS_PER_BLOCK; i++) {
> +		tmp = le32_to_cpu(node->in.nid[i]);
> +		if (!tmp)
> +			continue;
> +		fsck_failed_reconnect_file_dnode(sbi, tmp);
> +	}
> +}
> +
> +static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
> +					       nid_t nid)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	struct f2fs_node *node;
> +	struct node_info ni;
> +	nid_t tmp;
> +	int i, err;
> +
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +
> +	get_node_info(sbi, nid, &ni);
> +	err = dev_read_block(node, ni.blk_addr);
> +	ASSERT(err >= 0);
> +
> +	fsck->chk.valid_node_cnt--;
> +	fsck->chk.valid_blk_cnt--;
> +	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +
> +	for (i = 0; i < NIDS_PER_BLOCK; i++) {
> +		tmp = le32_to_cpu(node->in.nid[i]);
> +		if (!tmp)
> +			continue;
> +		fsck_failed_reconnect_file_idnode(sbi, tmp);
> +	}
> +}
> +
> +/*
> + * Counters and main_area_bitmap are already changed during checking
> + * inode block, so clear them. There is no need to clear new blocks
> + * allocted to lost+found.
> + */
> +static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	struct f2fs_node *node;
> +	struct node_info ni;
> +	nid_t nid;
> +	int ofs, i, err;
> +
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +
> +	get_node_info(sbi, ino, &ni);
> +	err = dev_read_block(node, ni.blk_addr);
> +	ASSERT(err >= 0);
> +
> +	/* clear inode counters */
> +	fsck->chk.valid_inode_cnt--;
> +	fsck->chk.valid_node_cnt--;
> +	fsck->chk.valid_blk_cnt--;
> +	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +
> +	/* clear xnid counters */
> +	if (node->i.i_xattr_nid) {
> +		nid = le32_to_cpu(node->i.i_xattr_nid);
> +		fsck->chk.valid_node_cnt--;
> +		fsck->chk.valid_blk_cnt--;
> +		get_node_info(sbi, nid, &ni);
> +		f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +	}
> +
> +	/* clear data counters */
> +	if(!(node->i.i_inline & F2FS_INLINE_DATA)) {
> +		ofs = get_extra_isize(node);
> +		for (i = 0; i < ADDRS_PER_INODE(&node->i); i++) {
> +			block_t addr = le32_to_cpu(node->i.i_addr[ofs + i]);
> +			if (!addr)
> +				continue;
> +			fsck->chk.valid_blk_cnt--;
> +			if (addr == NEW_ADDR)
> +				continue;
> +			f2fs_clear_main_bitmap(sbi, addr);
> +		}
> +	}
> +
> +	for (i = 0; i < 5; i++) {
> +		nid = le32_to_cpu(node->i.i_nid[i]);
> +		if (!nid)
> +			continue;
> +
> +		switch (i) {
> +		case 0: /* direct node */
> +		case 1:
> +			fsck_failed_reconnect_file_dnode(sbi, nid);
> +			break;
> +		case 2: /* indirect node */
> +		case 3:
> +			fsck_failed_reconnect_file_idnode(sbi, nid);
> +			break;
> +		case 4: /* double indirect node */
> +			fsck_failed_reconnect_file_didnode(sbi, nid);
> +			break;
> +		}
> +	}
> +}
> +
> +/*
> + * Scan unreachable nids and find only regular file inodes. If these files
> + * are not corrupted, reconnect them to lost+found.
> + *
> + * Since all unreachable nodes are already checked, we can allocate new
> + * blocks safely.
> + *
> + * This function returns the number of files been reconnected.
> + */
> +static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +	struct f2fs_node *lpf_node, *node;
> +	struct node_info ni;
> +	char *reconnect_bitmap;
> +	u32 blk_cnt;
> +	nid_t nid;
> +	int err, cnt = 0;
> +
> +	node = calloc(F2FS_BLKSIZE, 1);
> +	ASSERT(node);
> +
> +	reconnect_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
> +	ASSERT(reconnect_bitmap);
> +
> +	for (nid = 0; nid < fsck->nr_nat_entries; nid++) {
> +		if (f2fs_test_bit(nid, fsck->nat_area_bitmap)) {
> +			if (is_qf_ino(F2FS_RAW_SUPER(sbi), nid)) {
> +				DBG(1, "Not support quota inode [0x%x]\n",
> +				    nid);
> +				continue;
> +			}
> +
> +			get_node_info(sbi, nid, &ni);
> +			err = dev_read_block(node, ni.blk_addr);
> +			ASSERT(err >= 0);
> +
> +			/* reconnection will restore these nodes if needed */
> +			if (node->footer.ino != node->footer.nid) {
> +				DBG(1, "Not support non-inode node [0x%x]\n",
> +				    nid);
> +				continue;
> +			}
> +
> +			if (S_ISDIR(le16_to_cpu(node->i.i_mode))) {
> +				DBG(1, "Not support directory inode [0x%x]\n",
> +				    nid);
> +				continue;
> +			}
> +
> +			if (sanity_check_nid(sbi, nid, node,
> +					     F2FS_FT_REG_FILE, TYPE_INODE,
> +					     &ni)) {
> +				ASSERT_MSG("Invalid nid [0x%x]\n", nid);
> +				continue;
> +			}
> +
> +			DBG(1, "Check inode 0x%x\n", nid);
> +			blk_cnt = 1;
> +			fsck_chk_inode_blk(sbi, nid, F2FS_FT_REG_FILE,
> +					   node, &blk_cnt, &ni, NULL);
> +
> +			f2fs_set_bit(nid, reconnect_bitmap);
> +		}
> +	}
> +
> +	lpf_node = fsck_get_lpf(sbi);
> +	if (!lpf_node)
> +		goto out;
> +
> +	for (nid = 0; nid < fsck->nr_nat_entries; nid++) {
> +		if (f2fs_test_bit(nid, reconnect_bitmap)) {
> +			get_node_info(sbi, nid, &ni);
> +			err = dev_read_block(node, ni.blk_addr);
> +			ASSERT(err >= 0);
> +
> +			if (fsck_do_reconnect_file(sbi, lpf_node, node)) {
> +				DBG(1, "Failed to reconnect inode [0x%x]\n",
> +				    nid);
> +				fsck_failed_reconnect_file(sbi, nid);
> +				continue;
> +			}
> +
> +			/* FIXME: need update quota? */
> +			quota_add_inode_usage(fsck->qctx, nid, &node->i);
> +
> +			DBG(1, "Reconnected inode [0x%x] to lost+found\n", nid);
> +			cnt++;
> +		}
> +	}
> +
> +out:
> +	free(node);
> +	free(lpf_node);
> +	free(reconnect_bitmap);
> +	return cnt;
> +}
> +
>   int fsck_verify(struct f2fs_sb_info *sbi)
>   {
>   	unsigned int i = 0;
> @@ -2059,6 +2426,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
>   		}
>   	}
>   
> +	if (nr_unref_nid && c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
> +		i = fsck_reconnect_file(sbi);

nr_unref_nid should be updated here.   nr_unref_nid -= i;

> +		printf("\n[FSCK] Reconnect %u files to lost+found\n", i);
> +	}
> +
>   	if (fsck->hard_link_list_head != NULL) {
>   		node = fsck->hard_link_list_head;
>   		while (node) {
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 648c2db..8e133fa 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -243,6 +243,9 @@ int f2fs_mkdir(struct f2fs_sb_info *, struct dentry *);
>   int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
>   int inode_set_selinux(struct f2fs_sb_info *, u32, const char *);
>   int f2fs_find_path(struct f2fs_sb_info *, char *, nid_t *);
> +nid_t f2fs_lookup(struct f2fs_sb_info *, struct f2fs_node *, u8 *, int);
> +int f2fs_add_link(struct f2fs_sb_info *, struct f2fs_node *,
> +		const unsigned char *, int, nid_t, int, block_t, int);
>   
>   /* xattr.c */
>   void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *);
> diff --git a/fsck/mount.c b/fsck/mount.c
> index df53c48..9775e9e 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1587,6 +1587,8 @@ void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
>   	if (ino)
>   		nat_block->entries[entry_off].ino = cpu_to_le32(ino);
>   	nat_block->entries[entry_off].block_addr = cpu_to_le32(newaddr);
> +	if (c.func == FSCK)
> +		F2FS_FSCK(sbi)->entries[nid] = nat_block->entries[entry_off];
>   
>   	ret = dev_write_block(nat_block, block_addr);
>   	ASSERT(ret >= 0);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
