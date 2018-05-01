From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH 1/2] test-appliance: fix
 specifying f2fs mount options in config file
Date: Mon, 30 Apr 2018 22:17:46 -0400
Message-ID: <20180501021746.GG20585@thunk.org>
References: <20180419205020.16868-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fDKre-00032r-Tp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 May 2018 02:17:58 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fDKrb-00EGEv-Ov
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 May 2018 02:17:58 +0000
Content-Disposition: inline
In-Reply-To: <20180419205020.16868-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Apr 19, 2018 at 01:50:19PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> setup_mount_opts() is supposed to prepend "-o " to the mount options,
> but it failed to do so in the case where mount options are specified in
> a config file rather than on the command line.  Fix it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied, thanks.

					- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
