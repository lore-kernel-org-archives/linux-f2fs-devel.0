From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs-tools: enhance on-disk inode
 structure scalability
Date: Mon, 17 Jul 2017 15:22:54 -0700
Message-ID: <20170717222254.GC81128@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170716071251.25793-1-chao@kernel.org>
	<20170716071251.25793-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dXEPv-0005sM-0U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 22:23:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dXEPs-00045B-Gr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Jul 2017 22:23:02 +0000
Content-Disposition: inline
In-Reply-To: <20170716071251.25793-2-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

Nice work!
Looking at a glance, we need to consider backward compatibility where old f2fs
cannot interpret extra i_size. So, we need to add an option to enable this in
order for users to be aware of it.

On 07/16, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Adjust to change of kernel side:
> 
> This patch add new flag F2FS_EXTRA_ATTR storing in inode.i_inline
> to indicate that on-disk structure of current inode is extended.
> 
> In order to extend, we changed the inode structure a bit:
> 
> Original one:
> 
> struct f2fs_inode {
> 	...
> 	struct f2fs_extent i_ext;
> 	__le32 i_addr[DEF_ADDRS_PER_INODE];
> 	__le32 i_nid[DEF_NIDS_PER_INODE];
> }
> 
> Extended one:
> 
> struct f2fs_inode {
>         ...
>         struct f2fs_extent i_ext;
> 	union {
> 		struct {
> 			__le16 i_extra_isize;
> 			__le16 i_padding;

	union {
		struct {
			__le16 i_extra_isize;	/* extra inode attribute size */
			__le16 i_padding;	/* padding */
			__le32 i_extra_end[0];	/* for attribute size calculation */
		};
		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
	};

Need to update.

Thanks,

> 		};
> 		__le32 i_addr[DEF_ADDRS_PER_INODE];
> 	};
>         __le32 i_nid[DEF_NIDS_PER_INODE];
> }
> 
> Once F2FS_EXTRA_ATTR is set, we will steal four bytes in the head of
> i_addr field for storing i_extra_isize and i_padding. with i_extra_isize,
> we can calculate actual size of reserved space in i_addr, available
> attribute fields included in total extra attribute fields for current
> inode can be described as below:
> 
>   +--------------------+
>   | .i_mode            |
>   | ...                |
>   | .i_ext             |
>   +--------------------+
>   | .i_extra_isize     |-----+
>   | .i_padding         |     |
>   | .i_prjid           |     |
>   | .i_atime_extra     |     |
>   | .i_ctime_extra     |     |
>   | .i_mtime_extra     |<----+
>   | .i_inode_cs        |<----- store blkaddr/inline from here
>   | .i_xattr_cs        |
>   | ...                |
>   +--------------------+
>   |                    |
>   |    block address   |
>   |                    |
>   +--------------------+
>   | .i_nid             |
>   +--------------------+
>   |   node_footer      |
>   | (nid, ino, offset) |
>   +--------------------+
> 
> Hence, with this patch, we would enhance scalability of f2fs inode for
> storing more newly added attribute.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/dir.c         | 48 +++++++++++++++++++---------------
>  fsck/dump.c        |  6 ++---
>  fsck/f2fs.h        |  4 ++-
>  fsck/fsck.c        | 35 +++++++++++++++----------
>  fsck/fsck.h        |  2 +-
>  fsck/mount.c       | 20 ++++++++++-----
>  fsck/node.c        |  6 ++---
>  fsck/node.h        |  7 ++++-
>  fsck/segment.c     |  5 ++--
>  include/f2fs_fs.h  | 75 +++++++++++++++++++++++++++++++++++++++++-------------
>  lib/libf2fs.c      |  4 +--
>  mkfs/f2fs_format.c |  4 ++-
>  12 files changed, 143 insertions(+), 73 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 62bc7b9..d70183f 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -34,7 +34,8 @@ next:
>  
>  }
>  
> -void make_dentry_ptr(struct f2fs_dentry_ptr *d, void *src, int type)
> +void make_dentry_ptr(struct f2fs_dentry_ptr *d, struct f2fs_node *node_blk,
> +							void *src, int type)
>  {
>  	if (type == 1) {
>  		struct f2fs_dentry_block *t = (struct f2fs_dentry_block *)src;
> @@ -44,12 +45,16 @@ void make_dentry_ptr(struct f2fs_dentry_ptr *d, void *src, int type)
>  		d->dentry = t->dentry;
>  		d->filename = t->filename;
>  	} else {
> -		struct f2fs_inline_dentry *t = (struct f2fs_inline_dentry *)src;
> -		d->max = NR_INLINE_DENTRY;
> -		d->nr_bitmap = INLINE_DENTRY_BITMAP_SIZE;
> -		d->bitmap = t->dentry_bitmap;
> -		d->dentry = t->dentry;
> -		d->filename = t->filename;
> +		int entry_cnt = NR_INLINE_DENTRY(node_blk);
> +		int bitmap_size = INLINE_DENTRY_BITMAP_SIZE(node_blk);
> +		int reserved_size = INLINE_RESERVED_SIZE(node_blk);
> +
> +		d->max = entry_cnt;
> +		d->nr_bitmap = bitmap_size;
> +		d->bitmap = src;
> +		d->dentry = src + bitmap_size + reserved_size;
> +		d->filename = src + bitmap_size + reserved_size +
> +						SIZE_OF_DIR_ENTRY * entry_cnt;
>  	}
>  }
>  
> @@ -95,7 +100,7 @@ static struct f2fs_dir_entry *find_in_block(void *block,
>  {
>  	struct f2fs_dentry_ptr d;
>  
> -	make_dentry_ptr(&d, block, 1);
> +	make_dentry_ptr(&d, NULL, block, 1);
>  	return find_target_dentry(name, len, namehash, max_slots, &d);
>  }
>  
> @@ -258,7 +263,7 @@ start:
>  	goto start;
>  
>  add_dentry:
> -	make_dentry_ptr(&d, (void *)dentry_blk, 1);
> +	make_dentry_ptr(&d, NULL, (void *)dentry_blk, 1);
>  	f2fs_update_dentry(ino, file_type, &d, name, name_len, dentry_hash, bit_pos);
>  
>  	ret = dev_write_block(dentry_blk, dn.data_blkaddr);
> @@ -338,7 +343,7 @@ static void make_empty_dir(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
>  	ret = dev_write_block(dent_blk, blkaddr);
>  	ASSERT(ret >= 0);
>  
> -	inode->i.i_addr[0] = cpu_to_le32(blkaddr);
> +	inode->i.i_addr[get_extra_isize(inode)] = cpu_to_le32(blkaddr);
>  	free(dent_blk);
>  }
>  
> @@ -355,10 +360,10 @@ static void page_symlink(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
>  	get_node_info(sbi, ino, &ni);
>  
>  	/* store into inline_data */
> -	if (symlen + 1 <= MAX_INLINE_DATA) {
> +	if (symlen + 1 <= MAX_INLINE_DATA(inode)) {
>  		inode->i.i_inline |= F2FS_INLINE_DATA;
>  		inode->i.i_inline |= F2FS_DATA_EXIST;
> -		memcpy(&inode->i.i_addr[1], symname, symlen);
> +		memcpy(inline_data_addr(inode), symname, symlen);
>  		return;
>  	}
>  
> @@ -373,7 +378,7 @@ static void page_symlink(struct f2fs_sb_info *sbi, struct f2fs_node *inode,
>  	ret = dev_write_block(data_blk, blkaddr);
>  	ASSERT(ret >= 0);
>  
> -	inode->i.i_addr[0] = cpu_to_le32(blkaddr);
> +	inode->i.i_addr[get_extra_isize(inode)] = cpu_to_le32(blkaddr);
>  	free(data_blk);
>  }
>  
> @@ -398,7 +403,7 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
>  		ASSERT(de->link);
>  		mode |= S_IFLNK;
>  		size = strlen(de->link);
> -		if (size + 1 > MAX_INLINE_DATA)
> +		if (size + 1 > MAX_INLINE_DATA(node_blk))
>  			blocks++;
>  	} else {
>  		ASSERT(0);
> @@ -421,11 +426,12 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
>  	node_blk->i.i_current_depth = cpu_to_le32(1);
>  	node_blk->i.i_xattr_nid = 0;
>  	node_blk->i.i_flags = 0;
> -	node_blk->i.i_inline = F2FS_INLINE_XATTR;
> +	node_blk->i.i_inline = F2FS_INLINE_XATTR | F2FS_EXTRA_ATTR;
>  	node_blk->i.i_pino = cpu_to_le32(de->pino);
>  	node_blk->i.i_namelen = cpu_to_le32(de->len);
>  	memcpy(node_blk->i.i_name, de->name, de->len);
>  	node_blk->i.i_name[de->len] = 0;
> +	node_blk->i.i_extra_isize = cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
>  
>  	node_blk->footer.ino = cpu_to_le32(de->ino);
>  	node_blk->footer.nid = cpu_to_le32(de->ino);
> @@ -444,7 +450,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>  	struct f2fs_inode *inode = &(node->i);
>  	unsigned int dir_level = node->i.i_dir_level;
>  	nid_t ino = le32_to_cpu(node->footer.ino);
> -	char inline_data[MAX_INLINE_DATA];
> +	char inline_data[MAX_INLINE_DATA(node)];
>  	struct dnode_of_data dn = {0};
>  	struct f2fs_dentry_ptr d;
>  	unsigned long bit_pos = 0;
> @@ -453,8 +459,8 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>  	if (!(inode->i_inline & F2FS_INLINE_DENTRY))
>  		return 0;
>  
> -	memcpy(inline_data, inline_data_addr(node), MAX_INLINE_DATA);
> -	memset(inline_data_addr(node), 0, MAX_INLINE_DATA);
> +	memcpy(inline_data, inline_data_addr(node), MAX_INLINE_DATA(node));
> +	memset(inline_data_addr(node), 0, MAX_INLINE_DATA(node));
>  	inode->i_inline &= ~F2FS_INLINE_DENTRY;
>  
>  	ret = dev_write_block(node, p_blkaddr);
> @@ -472,8 +478,8 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>  		if (dn.data_blkaddr == NULL_ADDR)
>  			new_data_block(sbi, dentry_blk, &dn, CURSEG_HOT_DATA);
>  
> -		make_dentry_ptr(&src, (void *)inline_data, 2);
> -		make_dentry_ptr(&dst, (void *)dentry_blk, 1);
> +		make_dentry_ptr(&src, node, (void *)inline_data, 2);
> +		make_dentry_ptr(&dst, NULL, (void *)dentry_blk, 1);
>  
>  		 /* copy data from inline dentry block to new dentry block */
>  		memcpy(dst.bitmap, src.bitmap, src.nr_bitmap);
> @@ -493,7 +499,7 @@ int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
>  	}
>  
>  	make_empty_dir(sbi, node);
> -	make_dentry_ptr(&d, (void *)inline_data, 2);
> +	make_dentry_ptr(&d, node, (void *)inline_data, 2);
>  
>  	while (bit_pos < d.max) {
>  		struct f2fs_dir_entry *de;
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 22e2265..128dc53 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -322,14 +322,14 @@ static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		DBG(3, "ino[0x%x] has inline data!\n", nid);
>  		/* recover from inline data */
>  		dev_write_dump(((unsigned char *)node_blk) + INLINE_DATA_OFFSET,
> -							0, MAX_INLINE_DATA);
> +						0, MAX_INLINE_DATA(node_blk));
>  		return;
>  	}
>  
>  	/* check data blocks in inode */
>  	for (i = 0; i < ADDRS_PER_INODE(&node_blk->i); i++, ofs++)
> -		dump_data_blk(sbi, ofs * F2FS_BLKSIZE,
> -				le32_to_cpu(node_blk->i.i_addr[i]));
> +		dump_data_blk(sbi, ofs * F2FS_BLKSIZE, le32_to_cpu(
> +			node_blk->i.i_addr[get_extra_isize(node_blk) + i]));
>  
>  	/* check node blocks in inode */
>  	for (i = 0; i < 5; i++) {
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index d1626e3..871cffc 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -233,7 +233,9 @@ static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
>  
>  static inline void *inline_data_addr(struct f2fs_node *node_blk)
>  {
> -	return (void *)&(node_blk->i.i_addr[1]);
> +	int ofs = get_extra_isize(node_blk) + DEF_INLINE_RESERVED_SIZE;
> +
> +	return (void *)&(node_blk->i.i_addr[ofs]);
>  }
>  
>  static inline unsigned int ofs_of_node(struct f2fs_node *node_blk)
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 84196cf..7a81855 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -226,10 +226,13 @@ static int is_valid_summary(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  		goto out;
>  
>  	/* check its block address */
> -	if (node_blk->footer.nid == node_blk->footer.ino)
> -		target_blk_addr = node_blk->i.i_addr[ofs_in_node];
> -	else
> +	if (node_blk->footer.nid == node_blk->footer.ino) {
> +		int ofs = get_extra_isize(node_blk);
> +
> +		target_blk_addr = node_blk->i.i_addr[ofs + ofs_in_node];
> +	} else {
>  		target_blk_addr = node_blk->dn.addr[ofs_in_node];
> +	}
>  
>  	if (blk_addr == le32_to_cpu(target_blk_addr))
>  		ret = 1;
> @@ -658,20 +661,22 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  		goto check;
>  
>  	if((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
> -		if (le32_to_cpu(node_blk->i.i_addr[0]) != 0) {
> +		int ofs = get_extra_isize(node_blk);
> +
> +		if (le32_to_cpu(node_blk->i.i_addr[ofs]) != 0) {
>  			/* should fix this bug all the time */
>  			FIX_MSG("inline_data has wrong 0'th block = %x",
> -					le32_to_cpu(node_blk->i.i_addr[0]));
> -			node_blk->i.i_addr[0] = 0;
> +					le32_to_cpu(node_blk->i.i_addr[ofs]));
> +			node_blk->i.i_addr[ofs] = 0;
>  			node_blk->i.i_blocks = cpu_to_le64(*blk_cnt);
>  			need_fix = 1;
>  		}
>  		if (!(node_blk->i.i_inline & F2FS_DATA_EXIST)) {
> -			char buf[MAX_INLINE_DATA];
> -			memset(buf, 0, MAX_INLINE_DATA);
> +			char buf[MAX_INLINE_DATA(node_blk)];
> +			memset(buf, 0, MAX_INLINE_DATA(node_blk));
>  
> -			if (memcmp(buf, &node_blk->i.i_addr[1],
> -							MAX_INLINE_DATA)) {
> +			if (memcmp(buf, inline_data_addr(node_blk),
> +						MAX_INLINE_DATA(node_blk))) {
>  				FIX_MSG("inline_data has DATA_EXIST");
>  				node_blk->i.i_inline |= F2FS_DATA_EXIST;
>  				need_fix = 1;
> @@ -710,7 +715,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  	/* check data blocks in inode */
>  	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i);
>  						idx++, child.pgofs++) {
> -		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[idx]);
> +		int ofs = get_extra_isize(node_blk);
> +		block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[ofs + idx]);
>  
>  		/* check extent info */
>  		check_extent_info(&child, blkaddr, 0);
> @@ -724,9 +730,10 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  			if (!ret) {
>  				*blk_cnt = *blk_cnt + 1;
>  			} else if (c.fix_on) {
> -				node_blk->i.i_addr[idx] = 0;
> +				node_blk->i.i_addr[ofs + idx] = 0;
>  				need_fix = 1;
> -				FIX_MSG("[0x%x] i_addr[%d] = 0", nid, idx);
> +				FIX_MSG("[0x%x] i_addr[%d] = 0",
> +							nid, ofs + idx);
>  			}
>  		}
>  	}
> @@ -1362,7 +1369,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
>  	inline_dentry = inline_data_addr(node_blk);
>  	ASSERT(inline_dentry != NULL);
>  
> -	make_dentry_ptr(&d, inline_dentry, 2);
> +	make_dentry_ptr(&d, node_blk, inline_dentry, 2);
>  
>  	fsck->dentry_depth++;
>  	dentries = __chk_dentries(sbi, child,
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 5d2cfd6..1e8ed0b 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -221,7 +221,7 @@ block_t new_node_block(struct f2fs_sb_info *,
>  					struct dnode_of_data *, unsigned int);
>  void get_dnode_of_data(struct f2fs_sb_info *, struct dnode_of_data *,
>  					pgoff_t, int);
> -void make_dentry_ptr(struct f2fs_dentry_ptr *, void *, int);
> +void make_dentry_ptr(struct f2fs_dentry_ptr *, struct f2fs_node *, void *, int);
>  int f2fs_create(struct f2fs_sb_info *, struct dentry *);
>  int f2fs_mkdir(struct f2fs_sb_info *, struct dentry *);
>  int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
> diff --git a/fsck/mount.c b/fsck/mount.c
> index a0b0bea..693e4a8 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -41,6 +41,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
>  	unsigned int i = 0;
>  	int namelen = le32_to_cpu(inode->i_namelen);
>  	int enc_name = file_enc_name(inode);
> +	int ofs = __get_extra_isize(inode);
>  
>  	namelen = convert_encrypted_name(inode->i_name, namelen, en, enc_name);
>  	en[namelen] = '\0';
> @@ -87,12 +88,15 @@ void print_inode_info(struct f2fs_inode *inode, int name)
>  			le32_to_cpu(inode->i_ext.blk_addr),
>  			le32_to_cpu(inode->i_ext.len));
>  
> -	DISP_u32(inode, i_addr[0]);	/* Pointers to data blocks */
> -	DISP_u32(inode, i_addr[1]);	/* Pointers to data blocks */
> -	DISP_u32(inode, i_addr[2]);	/* Pointers to data blocks */
> -	DISP_u32(inode, i_addr[3]);	/* Pointers to data blocks */
> +	DISP_u16(inode, i_extra_isize);
> +	DISP_u16(inode, i_padding);
>  
> -	for (i = 4; i < ADDRS_PER_INODE(inode); i++) {
> +	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
> +	DISP_u32(inode, i_addr[ofs + 1]);	/* Pointers to data blocks */
> +	DISP_u32(inode, i_addr[ofs + 2]);	/* Pointers to data blocks */
> +	DISP_u32(inode, i_addr[ofs + 3]);	/* Pointers to data blocks */
> +
> +	for (i = ofs + 4; i < ADDRS_PER_INODE(inode); i++) {
>  		if (inode->i_addr[i] != 0x0) {
>  			printf("i_addr[0x%x] points data block\r\t\t[0x%4x]\n",
>  					i, le32_to_cpu(inode->i_addr[i]));
> @@ -1357,8 +1361,10 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
>  
>  	/* check its block address */
>  	if (node_blk->footer.nid == node_blk->footer.ino) {
> -		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs_in_node]);
> -		node_blk->i.i_addr[ofs_in_node] = cpu_to_le32(newaddr);
> +		int ofs = get_extra_isize(node_blk);
> +
> +		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs + ofs_in_node]);
> +		node_blk->i.i_addr[ofs + ofs_in_node] = cpu_to_le32(newaddr);
>  	} else {
>  		oldaddr = le32_to_cpu(node_blk->dn.addr[ofs_in_node]);
>  		node_blk->dn.addr[ofs_in_node] = cpu_to_le32(newaddr);
> diff --git a/fsck/node.c b/fsck/node.c
> index fe923e5..e37b817 100644
> --- a/fsck/node.c
> +++ b/fsck/node.c
> @@ -105,10 +105,10 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>   *
>   * By default, it sets inline_xattr and inline_data
>   */
> -static int get_node_path(unsigned long block,
> +static int get_node_path(struct f2fs_node *node, unsigned long block,
>  				int offset[4], unsigned int noffset[4])
>  {
> -	const long direct_index = DEF_ADDRS_PER_INODE_INLINE_XATTR;
> +	const long direct_index = ADDRS_PER_INODE(&node->i);
>  	const long direct_blks = ADDRS_PER_BLOCK;
>  	const long dptrs_per_blk = NIDS_PER_BLOCK;
>  	const long indirect_blks = ADDRS_PER_BLOCK * NIDS_PER_BLOCK;
> @@ -191,7 +191,7 @@ void get_dnode_of_data(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>  	int level, i;
>  	int ret;
>  
> -	level = get_node_path(index, offset, noffset);
> +	level = get_node_path(dn->inode_blk, index, offset, noffset);
>  
>  	nids[0] = dn->nid;
>  	parent = dn->inode_blk;
> diff --git a/fsck/node.h b/fsck/node.h
> index 721e5b7..cbf7ed7 100644
> --- a/fsck/node.h
> +++ b/fsck/node.h
> @@ -26,9 +26,14 @@ static inline int IS_INODE(struct f2fs_node *node)
>  	return ((node)->footer.nid == (node)->footer.ino);
>  }
>  
> +static inline __le32 *blkaddr_in_inode(struct f2fs_node *node)
> +{
> +	return node->i.i_addr + get_extra_isize(node);
> +}
> +
>  static inline __le32 *blkaddr_in_node(struct f2fs_node *node)
>  {
> -	return IS_INODE(node) ? node->i.i_addr : node->dn.addr;
> +	return IS_INODE(node) ? blkaddr_in_inode(node) : node->dn.addr;
>  }
>  
>  static inline block_t datablock_addr(struct f2fs_node *node_page,
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 6b2f6c1..e21339b 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -179,7 +179,7 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
>  	}
>  
>  	/* inline_data support */
> -	if (de->size <= MAX_INLINE_DATA) {
> +	if (de->size <= DEF_MAX_INLINE_DATA) {
>  		struct node_info ni;
>  		struct f2fs_node *node_blk;
>  		int ret;
> @@ -194,9 +194,10 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
>  
>  		node_blk->i.i_inline |= F2FS_INLINE_DATA;
>  		node_blk->i.i_inline |= F2FS_DATA_EXIST;
> +		node_blk->i.i_inline |= F2FS_EXTRA_ATTR;
>  		n = read(fd, buffer, BLOCK_SZ);
>  		ASSERT(n == de->size);
> -		memcpy(&node_blk->i.i_addr[1], buffer, de->size);
> +		memcpy(inline_data_addr(node_blk), buffer, de->size);
>  
>  		node_blk->i.i_size = cpu_to_le64(de->size);
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index dd2635b..88ceb61 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -167,6 +167,14 @@ static inline uint64_t bswap_64(uint64_t val)
>  		printf("%-30s" fmt, #member, ((ptr)->member));	\
>  	} while (0)
>  
> +#define DISP_u16(ptr, member)						\
> +	do {								\
> +		assert(sizeof((ptr)->member) == 2);			\
> +		printf("%-30s" "\t\t[0x%8x : %u]\n",			\
> +			#member, le16_to_cpu(((ptr)->member)),		\
> +			le16_to_cpu(((ptr)->member)));			\
> +	} while (0)
> +
>  #define DISP_u32(ptr, member)						\
>  	do {								\
>  		assert(sizeof((ptr)->member) <= 4);			\
> @@ -585,6 +593,8 @@ struct f2fs_extent {
>  #define F2FS_NAME_LEN		255
>  #define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
>  #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
> +#define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
> +					__get_extra_isize(inode))
>  #define ADDRS_PER_INODE(i)	addrs_per_inode(i)
>  #define DEF_ADDRS_PER_INODE_INLINE_XATTR				\
>  		(DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS)
> @@ -602,12 +612,27 @@ struct f2fs_extent {
>  #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
> +#define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
>  
> -#define MAX_INLINE_DATA (sizeof(__le32) *				\
> -			(DEF_ADDRS_PER_INODE_INLINE_XATTR - 1))
> +#if !defined(offsetof)
> +#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
> +#endif
>  
> +#define F2FS_TOTAL_EXTRA_ATTR_SIZE			\
> +	(offsetof(struct f2fs_inode, i_extra_end) -	\
> +	offsetof(struct f2fs_inode, i_extra_isize))	\
> +
> +#define MAX_INLINE_DATA(node) (sizeof(__le32) *				\
> +				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
> +				get_extra_isize(node) -			\
> +				DEF_INLINE_RESERVED_SIZE))
> +#define DEF_MAX_INLINE_DATA	(sizeof(__le32) *			\
> +				(DEF_ADDRS_PER_INODE_INLINE_XATTR -	\
> +				F2FS_TOTAL_EXTRA_ATTR_SIZE -		\
> +				DEF_INLINE_RESERVED_SIZE))
>  #define INLINE_DATA_OFFSET	(PAGE_CACHE_SIZE - sizeof(struct node_footer) \
> -				- sizeof(__le32)*(DEF_ADDRS_PER_INODE + 5 - 1))
> +				- sizeof(__le32)*(DEF_ADDRS_PER_INODE + 5 - \
> +				DEF_INLINE_RESERVED_SIZE))
>  
>  #define DEF_DIR_LEVEL		0
>  
> @@ -648,8 +673,14 @@ struct f2fs_inode {
>  
>  	struct f2fs_extent i_ext;	/* caching a largest extent */
>  
> -	__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
> -
> +	union {
> +		struct {
> +			__le16 i_extra_isize;	/* extra inode attribute size */
> +			__le16 i_padding;	/* padding */
> +			__le32 i_extra_end[0];	/* for attribute size calculation */
> +		};
> +		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
> +	};
>  	__le32 i_nid[5];		/* direct(2), indirect(2),
>  						double_indirect(1) node id */
>  } __attribute__((packed));
> @@ -909,23 +940,19 @@ struct f2fs_dentry_block {
>  	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
>  } __attribute__((packed));
>  
> +/* for inline stuff */
> +#define DEF_INLINE_RESERVED_SIZE	1
> +
>  /* for inline dir */
> -#define NR_INLINE_DENTRY	(MAX_INLINE_DATA * BITS_PER_BYTE / \
> +#define NR_INLINE_DENTRY(node)	(MAX_INLINE_DATA(node) * BITS_PER_BYTE / \
>  				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
>  				BITS_PER_BYTE + 1))
> -#define INLINE_DENTRY_BITMAP_SIZE	((NR_INLINE_DENTRY + \
> +#define INLINE_DENTRY_BITMAP_SIZE(node)	((NR_INLINE_DENTRY(node) + \
>  					BITS_PER_BYTE - 1) / BITS_PER_BYTE)
> -#define INLINE_RESERVED_SIZE	(MAX_INLINE_DATA - \
> +#define INLINE_RESERVED_SIZE(node)	(MAX_INLINE_DATA(node) - \
>  				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
> -				NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))
> -
> -/* inline directory entry structure */
> -struct f2fs_inline_dentry {
> -	__u8 dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];
> -	__u8 reserved[INLINE_RESERVED_SIZE];
> -	struct f2fs_dir_entry dentry[NR_INLINE_DENTRY];
> -	__u8 filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
> -} __attribute__((packed));
> +				NR_INLINE_DENTRY(node) + \
> +				INLINE_DENTRY_BITMAP_SIZE(node)))
>  
>  /* file types used in inode_info->flags */
>  enum FILE_TYPE {
> @@ -990,6 +1017,20 @@ extern int dev_read_version(void *, __u64, size_t);
>  extern void get_kernel_version(__u8 *);
>  f2fs_hash_t f2fs_dentry_hash(const unsigned char *, int);
>  
> +static inline bool f2fs_has_extra_isize(struct f2fs_inode *inode)
> +{
> +	return (inode->i_inline & F2FS_EXTRA_ATTR);
> +}
> +
> +static inline int __get_extra_isize(struct f2fs_inode *inode)
> +{
> +	if (f2fs_has_extra_isize(inode))
> +		return le16_to_cpu(inode->i_extra_isize) / sizeof(__le32);
> +	return 0;
> +}
> +
> +#define get_extra_isize(node)	__get_extra_isize(&node->i)
> +
>  #define F2FS_ZONED_NONE		0
>  #define F2FS_ZONED_HA		1
>  #define F2FS_ZONED_HM		2
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 31836db..a3091bb 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -457,8 +457,8 @@ f2fs_hash_t f2fs_dentry_hash(const unsigned char *name, int len)
>  unsigned int addrs_per_inode(struct f2fs_inode *i)
>  {
>  	if (i->i_inline & F2FS_INLINE_XATTR)
> -		return DEF_ADDRS_PER_INODE - F2FS_INLINE_XATTR_ADDRS;
> -	return DEF_ADDRS_PER_INODE;
> +		return CUR_ADDRS_PER_INODE(i) - F2FS_INLINE_XATTR_ADDRS;
> +	return CUR_ADDRS_PER_INODE(i);
>  }
>  
>  /*
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index ff1153a..4f2b403 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -922,10 +922,12 @@ static int f2fs_write_root_inode(void)
>  	raw_node->i.i_flags = 0;
>  	raw_node->i.i_current_depth = cpu_to_le32(1);
>  	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
> +	raw_node->i.i_inline = F2FS_EXTRA_ATTR;
> +	raw_node->i.i_extra_isize = cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
>  
>  	data_blk_nor = get_sb(main_blkaddr) +
>  		c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg;
> -	raw_node->i.i_addr[0] = cpu_to_le32(data_blk_nor);
> +	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);
>  
>  	raw_node->i.i_ext.fofs = 0;
>  	raw_node->i.i_ext.blk_addr = 0;
> -- 
> 2.13.0.90.g1eb437020

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
