From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH 8/8] xfs: support project in xfs_getattr()
Date: Fri, 1 Mar 2019 07:39:31 -0800
Message-ID: <20190301153931.GM21626@magnolia>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
 <1551449141-7884-9-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1gzkGJ-0003WC-Gl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 15:39:47 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gzkGH-00GvNL-Sr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 15:39:47 +0000
Content-Disposition: inline
In-Reply-To: <1551449141-7884-9-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Wang Shilong <wangshilong1991@gmail.com>
Cc: adilger@dilger.ca, Wang Shilong <wshilong@ddn.com>, lixi@ddn.com, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Fri, Mar 01, 2019 at 11:05:41PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> From: Wang Shilong <wshilong@ddn.com>
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/xfs/xfs_iops.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index c10466fe6ed4..a2f8c0f048cf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -501,6 +501,7 @@ xfs_vn_getattr(
>  	if (XFS_FORCED_SHUTDOWN(mp))
>  		return -EIO;
>  
> +	stat->projid = xfs_projid_to_kprojid(xfs_get_projid(ip));

I think we're supposed to set STATX_PROJID in the result mask if the
caller asks for it, right?

if (request_mask & STATX_PROJID) {
	stat->projid = xfs_projid_to_kprojid(xfs_get_projid(ip));
	stat->result_mask |= STATX_PROJID;
}

>  	stat->size = XFS_ISIZE(ip);
>  	stat->dev = inode->i_sb->s_dev;
>  	stat->mode = inode->i_mode;
> @@ -528,6 +529,8 @@ xfs_vn_getattr(
>  		stat->attributes |= STATX_ATTR_APPEND;
>  	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>  		stat->attributes |= STATX_ATTR_NODUMP;
> +	if (ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT)
> +		stat->attributes |= STATX_ATTR_PROJINHERIT;

I think we also have to set STATX_ATTR_PROJINHERIT in the
attributes_mask, but ... heh, XFS doesn't do that at all. :(

--D

>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFBLK:
> -- 
> 2.19.1
> 
