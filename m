From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] attr: adbjust acl_max of f2fs
Date: Wed, 3 May 2017 10:02:27 -0700
Message-ID: <20170503170227.GA93619@jaegeuk.local>
References: <20170428131307.3384-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d5xfl-0001t7-Bo
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 17:02:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d5xfj-00046R-6O
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 May 2017 17:02:41 +0000
Content-Disposition: inline
In-Reply-To: <20170428131307.3384-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: eguan@redhat.com, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello,

On 04/28, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> f2fs has set inline_xattr as a default option, and introduced a new option
> named 'noinline_xattr' for disabling default inline_xattr option. So in
> _acl_get_max we need to check 'noinline_xattr' string in fs option,
> otherwise we may select the wrong max acl number since we always found
> the string 'ininline_xattr' in fs option.
> 
> Additionally, f2fs has changed disk layout of xattr block a bit, so will
> contain one more entry in both inline and noinline xattr inode, this patch
> will modify the max acl number to adjust it.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  common/attr | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index ac139e61..6d4f68ed 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -43,11 +43,11 @@ _acl_get_max()
>  		echo 8191
>  		;;
>  	f2fs)
> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1

This breaks old kernel support which has no "noinline_xattr". It'd be good to
check "inline_xattr" again after checking "noinline_xattr". And, in terms of
different number of entries, can we get the number from local.config by adding
an export symbol likewise FSTYP?

Thanks,

>  		if [ $? -eq 0 ]; then
> -			echo 531
> +			echo 507
>  		else
> -			echo 506
> +			echo 532
>  		fi
>  		;;
>  	*)
> -- 
> 2.12.2.575.gb14f27f

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
