From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Fri, 20 May 2016 11:30:43 -0700
Message-ID: <1463769043.2835.30.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160520075849.GA8067@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160520075849.GA8067@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, 2016-05-20 at 00:58 -0700, Christoph Hellwig wrote:
> Please don't do the mistake of versioning the structure, but instead
> use feature flags, similar to what extN and modern XFS file systems do.

I am not sure that I follow to your point. The F2FS has "feature" field
(__le32 feature) into on-disk superblock (struct f2fs_super_block). The
suggested patch introduces the new F2FS_FEATURE_16TB_SUPPORT flag. And
it looks like as your comment.

So, necessary changes in on-disk layout for 16+TB volumes support will
be incompatible with current available version of F2FS driver. It means
that, anyway, we need to increase version of on-disk layout (major_ver
of struct f2fs_super_block). The presence of superblock's version and
F2FS_FEATURE_16TB_SUPPORT flag will be very useful for consistency
checking by fsck tool.

Another point is file system driver behavior. Old F2FS file system
driver (version 1) should refuse mount operation for the case of version
2 of on-disk layout and F2FS_FEATURE_16TB_SUPPORT flag presence. Or it
could mount in RO mode for the case of absence of
F2FS_FEATURE_16TB_SUPPORT flag and version 2 of on-disk layout. But,
finally, we need to change struct f2fs_inode, struct f2fs_extent and
struct direct_node for the case of version 2 of on-disk layout. It means
that file system driver of version 1 will be unable to mount a volume
with on-disk layout of version 2. The F2FS file system driver of version
2 should support (and mount) volume as for version 1 as for version 2 of
on-disk layout.

Finally, I believe that we need to increase as on-disk layout version
number as to introduce F2FS_FEATURE_16TB_SUPPORT flag. Checking of
version number and F2FS_FEATURE_16TB_SUPPORT flag will provide way of
checking file system volume consistency as for fsck tool as for file
system driver side. Let's imagine a situation that we don't change
on-disk layout version and we will receive superblock with
F2FS_FEATURE_16TB_SUPPORT flag during mount operation. What does it
mean? Does it mean that we have corrupted superblock state? For example,
we could decide that everything is OK. As a result, we will treat struct
f2fs_inode, struct f2fs_extent and struct direct_node in improper way.
It will be the reason of very sophisticated bugs and, potentially,
volume corruptions. 

Could you share your vision in more details?

Thanks,
Vyacheslav Dubeyko.


