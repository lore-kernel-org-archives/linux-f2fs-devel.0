From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] dump.f2fs: only dump nat inside the
 specified nid range
Date: Mon, 2 Jul 2018 14:12:03 +0800
Message-ID: <d847ed01-c40f-db2c-9170-5b78d394025e@huawei.com>
References: <069246af-0168-1da2-5cb9-0085aa4591f9@huawei.com>
 <20180702035934.23560-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fZs4v-0001fQ-2D
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 06:12:49 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fZs4s-007x5o-Jt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Jul 2018 06:12:48 +0000
In-Reply-To: <20180702035934.23560-1-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, chao@kernel.org, jaegeuk@kernel.org, heyunlei@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/2 11:59, Junling Zheng wrote:
> Only dump nat info of nids inside the specified range.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
> v1 -> v2:
>  1) change {start,end}_nat type into nid_t
>  2) put ASSERT() sentence close up to malloc
>  3) use F2FS_NODE_INO and F2FS_META_INO instead of ino 1 and 2
>  4) update man page of dump.f2fs
> 
>  fsck/dump.c     | 82 ++++++++++++++++++++++---------------------------
>  fsck/fsck.h     |  6 ++--
>  fsck/main.c     |  4 +--
>  man/dump.f2fs.8 | 13 ++++++--
>  4 files changed, 52 insertions(+), 53 deletions(-)
> 
> diff --git a/fsck/dump.c b/fsck/dump.c
> index 9236a43..942e874 100644
> --- a/fsck/dump.c
> +++ b/fsck/dump.c
> @@ -31,32 +31,35 @@ const char *seg_type_name[SEG_TYPE_MAX + 1] = {
>  	"SEG_TYPE_NONE",
>  };
>  
> -void nat_dump(struct f2fs_sb_info *sbi)
> +void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
>  {
> -	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct f2fs_nat_block *nat_block;
>  	struct f2fs_node *node_block;
> -	u32 nr_nat_blks, nid;
> +	nid_t nid;
>  	pgoff_t block_off;
>  	pgoff_t block_addr;
>  	char buf[BUF_SZ];
>  	int seg_off;
>  	int fd, ret, pack;

pack = 1;

> -	unsigned int i;
>  
>  	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
> -	node_block = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
>  	ASSERT(nat_block);
> -
> -	nr_nat_blks = get_sb(segment_count_nat) <<
> -				(sbi->log_blocks_per_seg - 1);
> +	node_block = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
> +	ASSERT(node_block);
>  
>  	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
>  	ASSERT(fd >= 0);
>  
> -	for (block_off = 0; block_off < nr_nat_blks; pack = 1, block_off++) {
> +	for (nid = start_nat; nid < end_nat; pack = 1, nid++) {
> +		struct f2fs_nat_entry raw_nat;
> +		struct node_info ni;
> +		if(nid == 0 || nid == F2FS_NODE_INO(sbi) ||
> +					nid == F2FS_META_INO(sbi))
> +			continue;
>  
> +		ni.nid = nid;
> +		block_off = nid / NAT_ENTRY_PER_BLOCK;
>  		seg_off = block_off >> sbi->log_blocks_per_seg;
>  		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
>  			(seg_off << sbi->log_blocks_per_seg << 1) +
> @@ -67,42 +70,11 @@ void nat_dump(struct f2fs_sb_info *sbi)
>  			pack = 2;

Nitpick,

How about replacing above codes with existed function current_nat_addr() to
avoid calculation bug, and since we need to set @pack, so we can add one
parameter to do that?

Thanks,

>  		}
>  
> -		ret = dev_read_block(nat_block, block_addr);
> -		ASSERT(ret >= 0);
> -
> -		nid = block_off * NAT_ENTRY_PER_BLOCK;
> -		for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
> -			struct f2fs_nat_entry raw_nat;
> -			struct node_info ni;
> -			ni.nid = nid + i;
> -
> -			if(nid + i  == 0 || nid + i  == 1 || nid + i == 2 )
> -				continue;
> -			if (lookup_nat_in_journal(sbi, nid + i,
> -							&raw_nat) >= 0) {
> -				node_info_from_raw_nat(&ni, &raw_nat);
> -				ret = dev_read_block(node_block, ni.blk_addr);
> -				ASSERT(ret >= 0);
> -				if (ni.blk_addr != 0x0) {
> -					memset(buf, 0, BUF_SZ);
> -					snprintf(buf, BUF_SZ,
> -						"nid:%5u\tino:%5u\toffset:%5u"
> -						"\tblkaddr:%10u\tpack:%d\n",
> -						ni.nid, ni.ino,
> -						le32_to_cpu(node_block->footer.flag) >>
> -							OFFSET_BIT_SHIFT,
> -						ni.blk_addr, pack);
> -					ret = write(fd, buf, strlen(buf));
> -					ASSERT(ret >= 0);
> -				}
> -			} else {
> -				node_info_from_raw_nat(&ni,
> -						&nat_block->entries[i]);
> -				if (ni.blk_addr == 0)
> -					continue;
> -
> -				ret = dev_read_block(node_block, ni.blk_addr);
> -				ASSERT(ret >= 0);
> +		if (lookup_nat_in_journal(sbi, nid, &raw_nat) >= 0) {
> +			node_info_from_raw_nat(&ni, &raw_nat);
> +			ret = dev_read_block(node_block, ni.blk_addr);
> +			ASSERT(ret >= 0);
> +			if (ni.blk_addr != 0x0) {
>  				memset(buf, 0, BUF_SZ);
>  				snprintf(buf, BUF_SZ,
>  					"nid:%5u\tino:%5u\toffset:%5u"
> @@ -114,6 +86,26 @@ void nat_dump(struct f2fs_sb_info *sbi)
>  				ret = write(fd, buf, strlen(buf));
>  				ASSERT(ret >= 0);
>  			}
> +		} else {
> +			ret = dev_read_block(nat_block, block_addr);
> +			ASSERT(ret >= 0);
> +			node_info_from_raw_nat(&ni,
> +					&nat_block->entries[nid % NAT_ENTRY_PER_BLOCK]);
> +			if (ni.blk_addr == 0)
> +				continue;
> +
> +			ret = dev_read_block(node_block, ni.blk_addr);
> +			ASSERT(ret >= 0);
> +			memset(buf, 0, BUF_SZ);
> +			snprintf(buf, BUF_SZ,
> +				"nid:%5u\tino:%5u\toffset:%5u"
> +				"\tblkaddr:%10u\tpack:%d\n",
> +				ni.nid, ni.ino,
> +				le32_to_cpu(node_block->footer.flag) >>
> +					OFFSET_BIT_SHIFT,
> +				ni.blk_addr, pack);
> +			ret = write(fd, buf, strlen(buf));
> +			ASSERT(ret >= 0);
>  		}
>  	}
>  
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 5530aff..4cac4e8 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -197,8 +197,8 @@ extern void write_nat_bits(struct f2fs_sb_info *, struct f2fs_super_block *,
>  /* dump.c */
>  struct dump_option {
>  	nid_t nid;
> -	int start_nat;
> -	int end_nat;
> +	nid_t start_nat;
> +	nid_t end_nat;
>  	int start_sit;
>  	int end_sit;
>  	int start_ssa;
> @@ -206,7 +206,7 @@ struct dump_option {
>  	int32_t blk_addr;
>  };
>  
> -extern void nat_dump(struct f2fs_sb_info *);
> +extern void nat_dump(struct f2fs_sb_info *, nid_t, nid_t);
>  extern void sit_dump(struct f2fs_sb_info *, unsigned int, unsigned int);
>  extern void ssa_dump(struct f2fs_sb_info *, int, int);
>  extern void dump_node(struct f2fs_sb_info *, nid_t, int);
> diff --git a/fsck/main.c b/fsck/main.c
> index f6d12b0..714e28a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -73,7 +73,7 @@ void dump_usage()
>  	MSG(0, "[options]:\n");
>  	MSG(0, "  -d debug level [default:0]\n");
>  	MSG(0, "  -i inode no (hex)\n");
> -	MSG(0, "  -n [NAT dump segno from #1~#2 (decimal), for all 0~-1]\n");
> +	MSG(0, "  -n [NAT dump nid from #1~#2 (decimal), for all 0~-1]\n");
>  	MSG(0, "  -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]\n");
>  	MSG(0, "  -S sparse_mode\n");
>  	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
> @@ -645,7 +645,7 @@ static void do_dump(struct f2fs_sb_info *sbi)
>  	if (opt->end_ssa == -1)
>  		opt->end_ssa = SM_I(sbi)->main_segments;
>  	if (opt->start_nat != -1)
> -		nat_dump(sbi);
> +		nat_dump(sbi, opt->start_nat, opt->end_nat);
>  	if (opt->start_sit != -1)
>  		sit_dump(sbi, opt->start_sit, opt->end_sit);
>  	if (opt->start_ssa != -1)
> diff --git a/man/dump.f2fs.8 b/man/dump.f2fs.8
> index 35616e5..eedba85 100644
> --- a/man/dump.f2fs.8
> +++ b/man/dump.f2fs.8
> @@ -10,6 +10,10 @@ dump.f2fs \- retrieve directory and file entries from an F2FS-formated image
>  .I inode number
>  ]
>  [
> +.B \-n
> +.I NAT range
> +]
> +[
>  .B \-s
>  .I SIT range
>  ]
> @@ -32,9 +36,9 @@ is used to retrieve f2fs metadata (usually in a disk partition).
>  \fIdevice\fP is the special file corresponding to the device (e.g.
>  \fI/dev/sdXX\fP).
>  
> -Currently, it can retrieve 1) a file given its inode number, 2) SIT entries into
> -a file, 3) SSA entries into a file, 4) reverse information from the given block
> -address.
> +Currently, it can retrieve 1) a file given its inode number, 2) NAT
> +entries into a file, 3) SIT entries into a file, 4) SSA entries into
> +a file, 5) reverse information from the given block address.
>  .PP
>  The exit code returned by
>  .B dump.f2fs
> @@ -44,6 +48,9 @@ is 0 on success and -1 on failure.
>  .BI \-i " inode number"
>  Specify an inode number to dump out.
>  .TP
> +.BI \-n " NAT range"
> +Specify a range presented by nids to dump NAT entries.
> +.TP
>  .BI \-s " SIT range"
>  Specify a range presented by segment numbers to dump SIT entries.
>  .TP
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
