From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] check: recognize f2fs through parameter
Date: Sat, 6 Oct 2018 17:32:07 +0800
Message-ID: <20181006093207.GI17817@desktop>
References: <20180930092653.122684-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guaneryu@gmail.com>) id 1g8iwg-0000Yg-Em
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Oct 2018 09:32:22 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g8iwe-001kA9-Il
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Oct 2018 09:32:22 +0000
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so5759733pgv.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 06 Oct 2018 02:32:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180930092653.122684-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sun, Sep 30, 2018 at 05:26:52PM +0800, Chao Yu wrote:
> Add a paramenter in check to configure $FSTYP for f2fs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  check | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/check b/check
> index f3c8021d94b9..a9024094721a 100755
> --- a/check
> +++ b/check
> @@ -59,6 +59,7 @@ check options
>      -pvfs2          test PVFS2
>      -tmpfs              test TMPFS
>      -ubifs              test ubifs
> +    -f2fs		test f2fs
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests
> @@ -263,6 +264,7 @@ while [ $# -gt 0 ]; do
>  	-pvfs2)		FSTYP=pvfs2 ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
>  	-ubifs)		FSTYP=ubifs ;;
> +	-f2fs)		FSTYP=f2fs ;;

The test harness should be able to detect the f2fs type from $TEST_DEV.
We add param to set FSTYP only when there's no way to tell the
filesystem type from the device.

Thanks,
Eryu

>  
>  	-g)	group=$2 ; shift ;
>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> -- 
> 2.18.0.rc1
> 
