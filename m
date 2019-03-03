From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/8] add generic interface to set/get project
Date: Mon, 4 Mar 2019 08:11:02 +1100
Message-ID: <20190303211102.GP23020@dastard>
References: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h0YOG-0002UC-54
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 21:11:20 +0000
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h0YOE-0025iW-32
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 03 Mar 2019 21:11:20 +0000
Content-Disposition: inline
In-Reply-To: <1551449141-7884-1-git-send-email-wshilong1991@gmail.com>
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

On Fri, Mar 01, 2019 at 11:05:33PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Currently, Filesystem use FS_IOC_FS_SETXATTR ioctl
> to change project ID of file. However we don't
> support ioctl on symlink files, and it is desirable
> to change symlink files' project ID just like uid/gid.
> 
> This patch try to reuse existed interface fchownat(),
> use group id to set project ID if flag AT_FCHOWN_PROJID
> passed in.
> 
> Also extend statx() calles to get symlink files' project
> ID and inherit attribute.

I'll mention the generic book-keeping stuff here:

- Series needs to be cc'd to linux-api@vger.kernel.org
- commit messages should be formatted similar to email. i.e. line
  wrap at 68-72 columns, not 50
- all of the patches have duplicate "From:" lines in the commit
  message.
- most of the patches are missing commit messages.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
