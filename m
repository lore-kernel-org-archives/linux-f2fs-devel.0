From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [xfstests-bld PATCH] test-appliance: support
 f2fs-tools v1.9 and later
Date: Fri, 6 Apr 2018 09:30:36 -0400
Message-ID: <20180406133036.GD7345@thunk.org>
References: <20180405222141.42376-1-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1f4Rva-000792-2A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Apr 2018 14:01:18 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f4RvK-00BxSM-6T
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Apr 2018 14:01:17 +0000
Content-Disposition: inline
In-Reply-To: <20180405222141.42376-1-ebiggers@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@google.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Apr 05, 2018 at 03:21:41PM -0700, Eric Biggers wrote:
> Pass the -f option to mkfs.f2fs when it appears to support it.  This is
> required by f2fs-tools v1.9 and later in order to format the filesystem
> even when an existing filesystem is detected.  But earlier versions did
> not accept this option.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for now, but ugh.  Grepping strings out of binaries is not
something I really like to depend upon.  Can we convince the f2fs
folks to provide a "/sbin/mkfs.f2fs -V" which prints a version string,
or some such?

						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
