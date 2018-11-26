From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 5/7] ext4: use IS_VERITY() to check inode's
 fsverity status
Date: Mon, 26 Nov 2018 12:36:15 -0500
Message-ID: <20181126173615.GB22888@thunk.org>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-6-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1gRKoN-0002Xr-VX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 17:36:43 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRKo2-00G5sC-Qh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 17:36:43 +0000
Content-Disposition: inline
In-Reply-To: <20181119052324.31456-6-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Nov 19, 2018 at 10:53:22AM +0530, Chandan Rajendra wrote:
> This commit now uses IS_VERITY() macro to check if fsverity is
> enabled on an inode.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

This patch causes a massive number of fsverity tests.  I suspect it's
due to a mismatch between the ext4's inode flags as opposed to the VFS
inode's flags.  I'll take a closer look in the next day or two.

Cheers,

						- Ted
