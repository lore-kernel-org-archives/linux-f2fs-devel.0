From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2 7/7] fsck.f2fs: reconnect unreachable
 files to lost+found
Date: Tue, 27 Feb 2018 21:16:30 -0800
Message-ID: <20180228051630.GD81737@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
 <20180223031801.231805-8-shengyong1@huawei.com>
 <0c849139-fdbe-9362-770c-ad4e9da57142@huawei.com>
 <8abbaedf-ae3b-741f-d36f-d65f96739065@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1equ6Y-001Nkq-H9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:16:38 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1equ6W-006qhO-Us
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:16:38 +0000
Content-Disposition: inline
In-Reply-To: <8abbaedf-ae3b-741f-d36f-d65f96739065@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/26, Sheng Yong wrote:
> Hi, Chao
> 
> On 2018/2/26 16:23, Chao Yu wrote:
> > On 2018/2/23 11:18, Sheng Yong wrote:
> > > This patch introduces lost_found feature to fsck. If a file is found
> > > unreachable by fsck. Fsck tries to reconnect the file to lost+found
> > > directory:
> > >    1. Scan all unreachable file inodes, ignore non-inodes ones and
> > >       directories.
> > >    2. Check them and fix incorrupted data to make sure filesystem
> > >       metadata (mainly counters and main/nat bitmap) are all consistent.
> > >    3. Reconnect these files to lost+found. If lost+found does not exist,
> > >       create it first. During reconnecting, expand lost+found's dentry
> > >       block automatically. Reconnected files are renamed after its ino
> > >       number.
> > >    4. If reconnect fails drop the node and restore filesystem metadata.
> > > 
> > > Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> > > ---
> > >   fsck/dir.c   |  19 ++-
> > >   fsck/fsck.c  | 388 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >   fsck/fsck.h  |   3 +
> > >   fsck/mount.c |   2 +
> > >   4 files changed, 409 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fsck/dir.c b/fsck/dir.c
> > > index b2ea18f..567a4e9 100644
> > > --- a/fsck/dir.c
> > > +++ b/fsck/dir.c
> > > @@ -176,6 +176,23 @@ static int f2fs_find_entry(struct f2fs_sb_info *sbi,
> > >   	return 0;
> > >   }
> [...]
> > > +
> > > +static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
> > > +				  struct f2fs_node *lpf,
> > > +				  struct f2fs_node *fnode)
> > > +{
> > > +	char name[80];
> > > +	size_t namelen;
> > > +	nid_t ino = le32_to_cpu(fnode->footer.ino);
> > > +	struct node_info ni;
> > > +	int ret;
> > > +
> > > +	namelen = snprintf(name, 80, "%u", ino);
> > > +	if (namelen >= 80)
> > > +		/* ignore terminating '\0', should never happen */
> > > +		namelen = 79;
> > > +
> > > +	if (f2fs_lookup(sbi, lpf, (u8 *)name, namelen)) {
> > > +		ASSERT_MSG("Name %s already exist in lost+found", name);
> > > +		return -EEXIST;
> > > +	}
> > > +
> > > +	get_node_info(sbi, le32_to_cpu(lpf->footer.ino), &ni);
> > > +	ret = f2fs_add_link(sbi, lpf, (unsigned char *)name, namelen,
> > > +			    ino, F2FS_FT_REG_FILE, ni.blk_addr, 0);
> > 
> > Need to change F2FS_FT_REG_FILE to ftype due to we expect to reconnect all kinds
> > of inode except directory, right?
> > 
> Right. My bad, will fix this in next version. Thanks.

Hi Sheng,

I merged this series except this patch. Please update this one only. :)

Thanks,

> 
> > > +	if (ret) {
> > > +		ASSERT_MSG("Failed to add inode [0x%x] to lost+found", ino);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* update fnode */
> > > +	memcpy(fnode->i.i_name, name, namelen);
> > > +	fnode->i.i_namelen = cpu_to_le32(namelen);
> > > +	fnode->i.i_pino = c.lpf_ino;
> > > +	get_node_info(sbi, le32_to_cpu(fnode->footer.ino), &ni);
> > > +	ret = dev_write_block(fnode, ni.blk_addr);
> > > +	ASSERT(ret >= 0);
> > > +
> > > +	DBG(1, "Reconnect inode [0x%x] to lost+found\n", ino);
> > > +	return 0;
> > > +}
> > > +
> [...]
> > > +
> > > +/*
> > > + * Scan unreachable nids and find only regular file inodes. If these files
> > > + * are not corrupted, reconnect them to lost+found.
> > > + *
> > > + * Since all unreachable nodes are already checked, we can allocate new
> > > + * blocks safely.
> > > + *
> > > + * This function returns the number of files been reconnected.
> > > + */
> > > +static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
> > > +{
> > > +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> > > +	struct f2fs_node *lpf_node, *node;
> > > +	struct node_info ni;
> > > +	char *reconnect_bitmap;
> > > +	u32 blk_cnt;
> > > +	nid_t nid;
> > > +	int err, cnt = 0, ftype;
> > > +
> > > +	node = calloc(F2FS_BLKSIZE, 1);
> > > +	ASSERT(node);
> > > +
> > > +	reconnect_bitmap = calloc(fsck->nat_area_bitmap_sz, 1);
> > > +	ASSERT(reconnect_bitmap);
> > > +
> > > +	for (nid = 0; nid < fsck->nr_nat_entries; nid++) {
> > > +		if (f2fs_test_bit(nid, fsck->nat_area_bitmap)) {
> > > +			if (is_qf_ino(F2FS_RAW_SUPER(sbi), nid)) {
> > > +				DBG(1, "Not support quota inode [0x%x]\n",
> > > +				    nid);
> > > +				continue;
> > > +			}
> > > +
> > > +			get_node_info(sbi, nid, &ni);
> > > +			err = dev_read_block(node, ni.blk_addr);
> > > +			ASSERT(err >= 0);
> > > +
> > > +			/* reconnection will restore these nodes if needed */
> > > +			if (node->footer.ino != node->footer.nid) {
> > > +				DBG(1, "Not support non-inode node [0x%x]\n",
> > > +				    nid);
> > > +				continue;
> > > +			}
> > > +
> > > +			if (S_ISDIR(le16_to_cpu(node->i.i_mode))) {
> > > +				DBG(1, "Not support directory inode [0x%x]\n",
> > > +				    nid);
> > > +				continue;
> > > +			}
> > > +
> > > +			ftype = map_de_type(le16_to_cpu(node->i.i_mode));
> > > +			if (sanity_check_nid(sbi, nid, node, ftype,
> > > +					     TYPE_INODE, &ni)) {
> > > +				ASSERT_MSG("Invalid nid [0x%x]\n", nid);
> > > +				continue;
> > > +			}
> > > +
> > > +			DBG(1, "Check inode 0x%x\n", nid);
> > > +			blk_cnt = 1;
> > > +			fsck_chk_inode_blk(sbi, nid, F2FS_FT_REG_FILE,
> > 
> > Ditto,
> > 
> Will fix it :)
> 
> Thanks,
> Sheng
> 
> > Thanks,
> > 
> > > +					   node, &blk_cnt, &ni, NULL);
> > > +
> > > +			f2fs_set_bit(nid, reconnect_bitmap);
> > > +		}
> > > +	}
> > > +
> > > +	lpf_node = fsck_get_lpf(sbi);
> > > +	if (!lpf_node)
> > > +		goto out;
> > > +
> > > +	for (nid = 0; nid < fsck->nr_nat_entries; nid++) {
> > > +		if (f2fs_test_bit(nid, reconnect_bitmap)) {
> > > +			get_node_info(sbi, nid, &ni);
> > > +			err = dev_read_block(node, ni.blk_addr);
> > > +			ASSERT(err >= 0);
> > > +
> > > +			if (fsck_do_reconnect_file(sbi, lpf_node, node)) {
> > > +				DBG(1, "Failed to reconnect inode [0x%x]\n",
> > > +				    nid);
> > > +				fsck_failed_reconnect_file(sbi, nid);
> > > +				continue;
> > > +			}
> > > +
> > > +			quota_add_inode_usage(fsck->qctx, nid, &node->i);
> > > +
> > > +			DBG(1, "Reconnected inode [0x%x] to lost+found\n", nid);
> > > +			cnt++;
> > > +		}
> > > +	}
> > > +
> > > +out:
> > > +	free(node);
> > > +	free(lpf_node);
> > > +	free(reconnect_bitmap);
> > > +	return cnt;
> > > +}
> > > +
> > >   int fsck_verify(struct f2fs_sb_info *sbi)
> > >   {
> > >   	unsigned int i = 0;
> > > @@ -2057,6 +2431,16 @@ int fsck_verify(struct f2fs_sb_info *sbi)
> > >   	printf("\n");
> > > +	if (c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
> > > +		for (i = 0; i < fsck->nr_nat_entries; i++)
> > > +			if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0)
> > > +				break;
> > > +		if (i < fsck->nr_nat_entries) {
> > > +			i = fsck_reconnect_file(sbi);
> > > +			printf("[FSCK] Reconnect %u files to lost+found\n", i);
> > > +		}
> > > +	}
> > > +
> > >   	for (i = 0; i < fsck->nr_nat_entries; i++) {
> > >   		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0) {
> > >   			printf("NID[0x%x] is unreachable\n", i);
> > > diff --git a/fsck/fsck.h b/fsck/fsck.h
> > > index 648c2db..8e133fa 100644
> > > --- a/fsck/fsck.h
> > > +++ b/fsck/fsck.h
> > > @@ -243,6 +243,9 @@ int f2fs_mkdir(struct f2fs_sb_info *, struct dentry *);
> > >   int f2fs_symlink(struct f2fs_sb_info *, struct dentry *);
> > >   int inode_set_selinux(struct f2fs_sb_info *, u32, const char *);
> > >   int f2fs_find_path(struct f2fs_sb_info *, char *, nid_t *);
> > > +nid_t f2fs_lookup(struct f2fs_sb_info *, struct f2fs_node *, u8 *, int);
> > > +int f2fs_add_link(struct f2fs_sb_info *, struct f2fs_node *,
> > > +		const unsigned char *, int, nid_t, int, block_t, int);
> > >   /* xattr.c */
> > >   void *read_all_xattrs(struct f2fs_sb_info *, struct f2fs_node *);
> > > diff --git a/fsck/mount.c b/fsck/mount.c
> > > index b8e7643..545f862 100644
> > > --- a/fsck/mount.c
> > > +++ b/fsck/mount.c
> > > @@ -1587,6 +1587,8 @@ void update_nat_blkaddr(struct f2fs_sb_info *sbi, nid_t ino,
> > >   	if (ino)
> > >   		nat_block->entries[entry_off].ino = cpu_to_le32(ino);
> > >   	nat_block->entries[entry_off].block_addr = cpu_to_le32(newaddr);
> > > +	if (c.func == FSCK)
> > > +		F2FS_FSCK(sbi)->entries[nid] = nat_block->entries[entry_off];
> > >   	ret = dev_write_block(nat_block, block_addr);
> > >   	ASSERT(ret >= 0);
> > > 
> > 
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
