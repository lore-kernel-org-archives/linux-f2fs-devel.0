From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: flush journal nat entries for
 nat_bits during unmount
Date: Mon, 9 Jul 2018 22:23:53 +0800
Message-ID: <ee638123-4114-badc-7d82-989e480ed45e@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> Let's flush journal nat entries for speed up in the next run.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 29237aeca041..0f076fb0d828 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	nid_t set_idx = 0;
>  	LIST_HEAD(sets);
>  
> +	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
> +	if (enabled_nat_bits(sbi, cpc)) {
> +		down_write(&nm_i->nat_tree_lock);
> +		remove_nats_in_journal(sbi);
> +		up_write(&nm_i->nat_tree_lock);
> +	}

The case will cover that nm_i->dirty_nat_cnt is zero and there is cached nats in
journal?

So enabled_nat_bits() below should be removed?

	if (enabled_nat_bits(sbi, cpc) ||
		!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
		remove_nats_in_journal(sbi);

Thanks,

> +
>  	if (!nm_i->dirty_nat_cnt)
>  		return;
>  
> 
