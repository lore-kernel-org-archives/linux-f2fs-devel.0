From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 2/2] fsck.f2fs: introduce
 fsck_chk_curseg_info
Date: Tue, 19 Jun 2018 20:11:32 +0800
Message-ID: <4b799e3b-a5fd-15e4-c50e-3771eb37fb4d@huawei.com>
References: <20180613015150.197854-1-shengyong1@huawei.com>
 <20180613015150.197854-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVFUZ-0000Cf-Cq
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 12:12:11 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVFUX-002mg3-Nn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 12:12:11 +0000
In-Reply-To: <20180613015150.197854-2-shengyong1@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/13 9:51, Sheng Yong wrote:
> If curseg is an empty segment, it will not be checked. This patch
> introduces fsck_chk_curseg_info() to check SIT/SSA type of cursegs
> to avoid curseg corruption.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/fsck.c | 34 ++++++++++++++++++++++++++++++++++
>  fsck/fsck.h |  1 +
>  fsck/main.c |  2 ++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 5b6dbc8..cfd939f 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2422,6 +2422,40 @@ out:
>  	return cnt;
>  }
>  
> +int fsck_chk_curseg_info(struct f2fs_sb_info *sbi)
> +{
> +	struct curseg_info *curseg;
> +	struct seg_entry *se;
> +	struct f2fs_summary_block *sum_blk;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < NO_CHECK_TYPE; i++) {
> +		curseg = CURSEG_I(sbi, i);
> +		se = get_seg_entry(sbi, curseg->segno);
> +		sum_blk = curseg->sum_blk;
> +
> +		if (se->type != i) {
> +			ASSERT_MSG("Incorrect curseg [%d]: segno [0x%x] "
> +				   "type(SIT) [%d]", i, curseg->segno,
> +				   se->type);
> +			se->type = i;

Need to check c.fix_on to decide fix se->type here?

> +			ret = -1;
> +		}
> +		if (i <= CURSEG_COLD_DATA && IS_SUM_DATA_SEG(sum_blk->footer)) {
> +			continue;
> +		} else if (i > CURSEG_COLD_DATA && IS_SUM_NODE_SEG(sum_blk->footer)) {
> +			continue;
> +		} else {
> +			ASSERT_MSG("Incorrect curseg [%d]: segno [0x%x] "
> +				   "type(SSA) [%d]", i, curseg->segno,
> +				   sum_blk->footer.entry_type);

Ditto.

Thanks,

> +			ret = -1;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int fsck_verify(struct f2fs_sb_info *sbi)
>  {
>  	unsigned int i = 0;
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index cbe7fc4..5530aff 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -144,6 +144,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
>  int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
>  		struct child_info *);
>  int fsck_chk_meta(struct f2fs_sb_info *sbi);
> +int fsck_chk_curseg_info(struct f2fs_sb_info *);
>  int convert_encrypted_name(unsigned char *, int, unsigned char *, int);
>  
>  extern void update_free_segments(struct f2fs_sb_info *);
> diff --git a/fsck/main.c b/fsck/main.c
> index 09026c9..f6d12b0 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -578,6 +578,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
>  
>  	print_cp_state(flag);
>  
> +	fsck_chk_curseg_info(sbi);
> +
>  	if (!c.fix_on && !c.bug_on) {
>  		switch (c.preen_mode) {
>  		case PREEN_MODE_1:
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
