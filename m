From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [xfstests-bld PATCH] test-appliance: support
 f2fs-tools v1.9 and later
Date: Mon, 9 Apr 2018 12:00:14 -0700
Message-ID: <20180409190014.GB203367@google.com>
References: <20180405222141.42376-1-ebiggers@google.com>
 <20180406133036.GD7345@thunk.org>
Reply-To: Eric Biggers <ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@google.com>) id 1f5c1k-000241-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 19:00:28 +0000
Received: from mail-pl0-f65.google.com ([209.85.160.65])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f5c1f-005iwv-59
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Apr 2018 19:00:28 +0000
Received: by mail-pl0-f65.google.com with SMTP id 91-v6so5762251pld.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Apr 2018 12:00:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180406133036.GD7345@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Apr 06, 2018 at 09:30:36AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Apr 05, 2018 at 03:21:41PM -0700, Eric Biggers wrote:
> > Pass the -f option to mkfs.f2fs when it appears to support it.  This is
> > required by f2fs-tools v1.9 and later in order to format the filesystem
> > even when an existing filesystem is detected.  But earlier versions did
> > not accept this option.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Applied for now, but ugh.  Grepping strings out of binaries is not
> something I really like to depend upon.  Can we convince the f2fs
> folks to provide a "/sbin/mkfs.f2fs -V" which prints a version string,
> or some such?
> 

Yes, it's ugly.  As something maybe a bit better, I've proposed

	mkfs.f2fs --help |& grep -q "[[:space:]]-f[[:space:]|]"
	
in v2 of the xfstests patch to common/config.  So if that gets accepted into
xfstests I'll change this to use the same method.

Thanks,

Eric

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
