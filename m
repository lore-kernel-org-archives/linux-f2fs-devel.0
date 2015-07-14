From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH f2fs] f2fs: f2fs_write_cache_pages() can be static
Date: Mon, 13 Jul 2015 17:30:15 -0700
Message-ID: <20150714003015.GA69788@jaegeuk-mac02.mot.com>
References: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
 <20150714002334.GA610@lkp-sb04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150714002334.GA610@lkp-sb04>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Chao Yu <chao2.yu@samsung.com>, kbuild-all@01.org, Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Merged this into the original patch.
Thanks,

On Tue, Jul 14, 2015 at 08:23:34AM +0800, kbuild test robot wrote:
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1724986..ea13e3e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1133,7 +1133,7 @@ static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
>   * The major change is making write step of cold data page separately from
>   * warm/hot data page.
>   */
> -int f2fs_write_cache_pages(struct address_space *mapping,
> +static int f2fs_write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data)
>  {
