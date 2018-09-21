From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to recover inode's uid/gid during POR
Date: Fri, 21 Sep 2018 14:20:49 +0800
Message-ID: <f2479038-3e4e-63e3-083e-d125b4a4d919@huawei.com>
References: <20180920094130.124622-1-yuchao0@huawei.com>
 <20180921060629.GA13865@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921060629.GA13865@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Christoph,

On 2018/9/21 14:06, Christoph Hellwig wrote:
> On Thu, Sep 20, 2018 at 05:41:30PM +0800, Chao Yu wrote:
>> Step to reproduce this bug:
>> 1. logon as root
>> 2. mount -t f2fs /dev/sdd /mnt;
>> 3. touch /mnt/file;
>> 4. chown system /mnt/file; chgrp system /mnt/file;
>> 5. xfs_io -f /mnt/file -c "fsync";
>> 6. godown /mnt;
>> 7. umount /mnt;
>> 8. mount -t f2fs /dev/sdd /mnt;
> 
> Please wire this up for xfstests (as a generic test).

No problem, I just plan to.

Out of curiosity, are you filter some key words like 'recover' in your
email client to find this so quickly?

Thanks,

> 
> 
