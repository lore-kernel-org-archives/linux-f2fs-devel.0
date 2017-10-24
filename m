From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2 6/6] f2fs: give up CP_TRIMMED_FLAG if it
 drops discards
Date: Tue, 24 Oct 2017 16:24:22 +0800
Message-ID: <20280b72-f2c1-7a43-ebd4-9c5fbac725a9@huawei.com>
References: <20171004010837.9809-1-chao@kernel.org>
 <20171004010837.9809-6-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e6uWy-0004i0-MW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Oct 2017 08:25:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e6uWw-00004x-MK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Oct 2017 08:25:48 +0000
In-Reply-To: <20171004010837.9809-6-chao@kernel.org>
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
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/10/4 9:08, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> In ->umount, once we drop remained discard entries, we should not
> set CP_TRIMMED_FLAG with another checkpoint.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - rebase on last codes of Jaegeuk's dev-test branch.
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/segment.c | 15 +++++++++++----
>  fs/f2fs/super.c   |  5 +++--
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f274805e231d..c85f49c41003 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2565,7 +2565,7 @@ void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
>  						unsigned int granularity);
>  void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
>  void stop_discard_thread(struct f2fs_sb_info *sbi);
> -void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
> +bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
>  void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  void release_discard_addrs(struct f2fs_sb_info *sbi);
>  int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4a108321233d..bfbcff8339c5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1196,12 +1196,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	return issued;
>  }
>  
> -static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
> +static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct list_head *pend_list;
>  	struct discard_cmd *dc, *tmp;
>  	int i;
> +	bool dropped = false;
>  
>  	mutex_lock(&dcc->cmd_lock);
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> @@ -1209,9 +1210,12 @@ static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>  			__remove_discard_cmd(sbi, dc);
> +			dropped = true;
>  		}
>  	}
>  	mutex_unlock(&dcc->cmd_lock);
> +
> +	return dropped;
>  }
>  
>  static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
> @@ -1306,15 +1310,18 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
>  }
>  
>  /* This comes from f2fs_put_super */
> -void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
> +bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct discard_policy dpolicy;
> +	bool dropped;
>  
>  	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
>  	__issue_discard_cmd(sbi, &dpolicy);
> -	__drop_discard_cmd(sbi);
> +	dropped = __drop_discard_cmd(sbi);
>  	__wait_all_discard_cmd(sbi, &dpolicy);
> +
> +	return dropped;
>  }
>  
>  static int issue_discard_thread(void *data)
> @@ -1659,7 +1666,7 @@ void init_discard_policy(struct discard_policy *dpolicy,
>  		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
>  		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
>  		dpolicy->io_aware_gran = MAX_PLIST_NUM;
> -		dpolicy->io_aware = false;
> +		dpolicy->io_aware = true;

I notice this change should not belong to this patch, could you please help to
move this into "f2fs: split discard policy" in your branch?

Thanks,

>  	} else if (discard_type == DPOLICY_FSTRIM) {
>  		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
>  		dpolicy->io_aware_gran = MAX_PLIST_NUM;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a13269d1a1f0..1d68c18a487b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -807,6 +807,7 @@ static void f2fs_put_super(struct super_block *sb)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	int i;
> +	bool dropped;
>  
>  	f2fs_quota_off_umount(sb);
>  
> @@ -827,9 +828,9 @@ static void f2fs_put_super(struct super_block *sb)
>  	}
>  
>  	/* be sure to wait for any on-going discard commands */
> -	f2fs_wait_discard_bios(sbi, true);
> +	dropped = f2fs_wait_discard_bios(sbi);
>  
> -	if (f2fs_discard_en(sbi) && !sbi->discard_blks) {
> +	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
>  		struct cp_control cpc = {
>  			.reason = CP_UMOUNT | CP_TRIMMED,
>  		};
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
