From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/7] f2fs: use IS_ENCRYPTED() to check
 encryption status
Date: Mon, 26 Nov 2018 12:34:35 -0500
Message-ID: <20181126173435.GA22888@thunk.org>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-3-chandan@linux.vnet.ibm.com>
 <20181119212332.GB33805@jaegeuk-macbookpro.roam.corp.google.com>
 <20181126034132.GC7904@thunk.org> <20181126040038.GD7904@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1gRKmh-0002SI-Ts
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 17:34:59 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRKmR-004UHz-A5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 17:34:59 +0000
Content-Disposition: inline
In-Reply-To: <20181126040038.GD7904@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Sun, Nov 25, 2018 at 11:00:38PM -0500, Theodore Y. Ts'o wrote:
> 
> It might be that the simplest way to solve things is to merge the f2fs
> dev branch up to 79c66e75720c.  This will have the net effect of
> including the five patches listed above onto the fscrypt git tree.  So
> long you don't plan to rebase or otherwise change these five patches,
> it should avoid any merge conflicts.

I've set up a git branch which has the f2fs dev branch, 4.20-rc4, the
fsverity patches, and part of Chandan's patch series here:

git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git test-working

There is a minor conflict when I did a trial merge with f2fs.git's dev
branch, but it's pretty obvious to how to resolve it.

Jaegeuk, Eric, Chandan, please take a look and let me know what you
think.

	    	 		       	  - Ted
