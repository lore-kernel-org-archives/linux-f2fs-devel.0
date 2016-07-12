From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: return proper error code
Date: Tue, 12 Jul 2016 09:45:43 +0800
Message-ID: <a4172278-7eca-1841-89b2-fddd72a92ba8@huawei.com>
References: <74f6ce4.4fb.155d71ccc53.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bMmm5-0001Nl-7Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 01:46:13 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bMmm1-0006eG-Ml
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 01:46:13 +0000
In-Reply-To: <74f6ce4.4fb.155d71ccc53.Coremail.kernelpatch@126.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/7/11 7:20, Tiezhu Yang wrote:
> When the length of file name is more than F2FS_NAME_LEN,

Seem @name indicates a xattr/key name, not a file name.

Thanks,

> it should return -ENAMETOOLONG.
> 
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
> ---
>  fs/f2fs/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 28a5023..b225062 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -364,7 +364,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>  
>  	len = strlen(name);
>  	if (len > F2FS_NAME_LEN)
> -		return -ERANGE;
> +		return -ENAMETOOLONG;
>  
>  	base_addr = read_all_xattrs(inode, ipage);
>  	if (!base_addr)
> @@ -458,7 +458,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>  	len = strlen(name);
>  
>  	if (len > F2FS_NAME_LEN)
> -		return -ERANGE;
> +		return -ENAMETOOLONG;
>  
>  	if (size > MAX_VALUE_LEN(inode))
>  		return -E2BIG;
> 


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
