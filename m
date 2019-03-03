From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] fchownat.2: add project support updates
Date: Mon, 4 Mar 2019 10:08:20 +1100
Message-ID: <20190303230820.GU23020@dastard>
References: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h0aDf-0003pr-1z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 23:08:31 +0000
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h0aDd-009RuV-Kh
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 23:08:31 +0000
Content-Disposition: inline
In-Reply-To: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
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
Cc: adilger@dilger.ca, linux-man@vger.kernel.org, Wang Shilong <wshilong@ddn.com>, lixi@ddn.com, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Fri, Mar 01, 2019 at 11:06:22PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> From: Wang Shilong <wshilong@ddn.com>
> 
> Cc: linux-man@vger.kernel.org
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  man2/chown.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/chown.2 b/man2/chown.2
> index 50db789ac..fad74df20 100644
> --- a/man2/chown.2
> +++ b/man2/chown.2
> @@ -217,6 +217,11 @@ instead operate on the link itself, like
>  .BR fchownat ()
>  dereferences symbolic links, like
>  .BR chown ().)
> +.TP
> +.B AT_FCHOWN_PROJID
> +Use
> +.I group
> +to change file's project ID instead of its group ID.

Needs to document init_user_ns constraint.

>  .PP
>  See
>  .BR openat (2)

Also missing new ENOSPC error that attempting to change a project ID
can result in. Also should document the EPERM error condition when
changing project ID in wrong userns, and EINVAL if an invalid
project ID is supplied.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
