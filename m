From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
Date: Thu, 20 Sep 2018 23:06:29 -0700
Message-ID: <20180921060629.GA13865@infradead.org>
References: <20180920094130.124622-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920094130.124622-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Sep 20, 2018 at 05:41:30PM +0800, Chao Yu wrote:
> Step to reproduce this bug:
> 1. logon as root
> 2. mount -t f2fs /dev/sdd /mnt;
> 3. touch /mnt/file;
> 4. chown system /mnt/file; chgrp system /mnt/file;
> 5. xfs_io -f /mnt/file -c "fsync";
> 6. godown /mnt;
> 7. umount /mnt;
> 8. mount -t f2fs /dev/sdd /mnt;

Please wire this up for xfstests (as a generic test).
