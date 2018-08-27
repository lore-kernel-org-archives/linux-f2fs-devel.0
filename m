From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] add configure option --with-root-libdir
Date: Mon, 27 Aug 2018 19:56:19 -0400
Message-ID: <20180827235619.GA2304@thunk.org>
References: <20180820030407.13225-1-tytso@mit.edu>
 <20180827155114.GG2311@thunk.org>
 <20180827165744.GB74162@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fuRN1-00011t-FD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 23:56:31 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuRMz-000JsK-RG
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 23:56:31 +0000
Content-Disposition: inline
In-Reply-To: <20180827165744.GB74162@jaegeuk-macbookpro.roam.corp.google.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On Mon, Aug 27, 2018 at 09:57:44AM -0700, Jaegeuk Kim wrote:
> 
> Thanks. I've added this and been testing with other patches for next release.
>

Are you planning on doing a new release soon?

I'm also wondering if you could give some color commentary on how
often you plan on bumping the shared version library numbers?  The
reason why I ask is because there is a Debian package which depends on
libf2fs and libf2fs-format, android-libf2fs-utils.  It appears to be
part of the Android SDK.

I was about to send the Debian maintainer of android-libf2fs-utils
package a ping asking him or her to relink against the latest so
versions --- libf2fs.so.5 and libf2fs-format.so.4.  But if the next
release is going to involve a bump of the so versions again, I'll hold
off requesting a rebuild of the package.

And if the shared libraries are going to be regularly bumped due to
incompatible ABI changes, should I recommend the andorid-f2fs-utils to
statically link instead of link against the f2fs shared libraries?

(I haven't bumped the e2fsprogs so versions in over a decade, but
that's because I had carefully designed the interfaces to allow for
backwards compatibility as we added new features to the file system.
I didn't know if that was part of your plan for f2fs-tools)

Thanks!!

						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
