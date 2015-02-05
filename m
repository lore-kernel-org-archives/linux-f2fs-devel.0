From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 3/8 v4] common/rc: add _require_norecovery
Date: Thu, 5 Feb 2015 13:08:31 +1100
Message-ID: <20150205020831.GD12722@dastard>
References: <1423004840-45315-1-git-send-email-jaegeuk@kernel.org>
 <1423004840-45315-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <fstests-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423004840-45315-4-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Feb 03, 2015 at 03:07:15PM -0800, Jaegeuk Kim wrote:
> This patch adds checking code whether filesystem supports norecovery mount
> option or not.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index d413721..72e2f99 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2331,6 +2331,14 @@ _require_scratch_shutdown()
>  	_scratch_unmount
>  }
>  
> +# Does norecovery support by this fs?
> +_require_norecovery()
> +{
> +        _scratch_mount -o ro,norecovery || \
> +                _notrun "$FSTYP does not support norecovery"
> +	_scratch_unmount
> +}

What's the point of making tests that use an XFS specific mount
option generic? If it requires this it is still an XFS specific
test, right?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
