From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Possible Bug in move_encrypted_block
Date: Mon, 21 Sep 2015 11:51:22 -0700
Message-ID: <20150921185122.GD20551@jaegeuk-mac02.mot.com>
References: <55FD9D08.5050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ze6BO-0002uz-JM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 18:51:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ze6BN-0006sN-SR for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 18:51:22 +0000
Content-Disposition: inline
In-Reply-To: <55FD9D08.5050501@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: nick <xerofoify@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

On Sat, Sep 19, 2015 at 01:36:08PM -0400, nick wrote:
> Greetings Jaeguek and others.
> Below are the lines fora possible bug in  move_encrypted_block:
> err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
>         if (err)
>                 goto out;
> Also calls of get_dnode_of_data need to hold the semaphone for the superblock
> this call is being done on to avoid concurrent access on data being received

IIUC, the f2fs_lock_op() is not neeeded here. Do you mean this?
To be honest, I can't catch your point.

Thanks,

> here from the superblock and file system on disk. In addition unless I get a
> reply to this I will not be sending in a bug fix for this.
> Nick

------------------------------------------------------------------------------
