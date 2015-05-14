From: hujianyang <hujianyang@huawei.com>
Subject: Re: Space leak in f2fs
Date: Thu, 14 May 2015 09:40:25 +0800
Message-ID: <5553FD09.9030508@huawei.com>
References: <5552FA7D.7000704@huawei.com>
	<20150513174417.GA56247@jaegeuk-mac02.mot.com>
	<20150514002417.GC68412@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hujianyang@huawei.com>) id 1Ysi9K-00013U-2Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 01:41:22 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ysi9F-0007sh-DW
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 01:41:22 +0000
In-Reply-To: <20150514002417.GC68412@jaegeuk-mac02>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

I've tested this patch. It's OK now. Seems this problem is fixed.

I'd like to push this patch to my local tree and run a formal
stress test next week. Will you push this patch to f2fs-dev branch?

If you have other modification to this fix, please let me know.

Thanks very much!
Hu

On 2015/5/14 8:24, Jaegeuk Kim wrote:
> Hi Hu,
> 
> Found a bug in the previous patch.
> Could you check this out?
> 
> Thanks,
> 
> ---
>  fs/f2fs/super.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 19438f2..647591b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -431,8 +431,17 @@ static int f2fs_drop_inode(struct inode *inode)
>  	 *    - f2fs_gc -> iput -> evict
>  	 *       - inode_wait_for_writeback(inode)
>  	 */
> -	if (!inode_unhashed(inode) && inode->i_state & I_SYNC)
> +	if (!inode_unhashed(inode) && inode->i_state & I_SYNC) {
> +		if (!inode->i_nlink && !is_bad_inode(inode)) {
> +			spin_unlock(&inode->i_lock);
> +			i_size_write(inode, 0);
> +
> +			if (F2FS_HAS_BLOCKS(inode))
> +				f2fs_truncate(inode);
> +			spin_lock(&inode->i_lock);
> +		}
>  		return 0;
> +	}
>  	return generic_drop_inode(inode);
>  }
>  
> 



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
