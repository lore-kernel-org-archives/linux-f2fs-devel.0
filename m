From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] add configure option --with-root-libdir
Date: Tue, 28 Aug 2018 00:12:02 -0700
Message-ID: <20180828071202.GA29049@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180820030407.13225-1-tytso@mit.edu>
 <20180827155114.GG2311@thunk.org>
 <20180827165744.GB74162@jaegeuk-macbookpro.roam.corp.google.com>
 <20180827235619.GA2304@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fuYAg-00020l-UG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 07:12:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuYAe-000dUT-Qy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 07:12:14 +0000
Content-Disposition: inline
In-Reply-To: <20180827235619.GA2304@thunk.org>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On 08/27, Theodore Y. Ts'o wrote:
> On Mon, Aug 27, 2018 at 09:57:44AM -0700, Jaegeuk Kim wrote:
> > 
> > Thanks. I've added this and been testing with other patches for next release.
> >
> 
> Are you planning on doing a new release soon?
> 
> I'm also wondering if you could give some color commentary on how
> often you plan on bumping the shared version library numbers?  The
> reason why I ask is because there is a Debian package which depends on
> libf2fs and libf2fs-format, android-libf2fs-utils.  It appears to be
> part of the Android SDK.

I think f2fs-tools is getting much firmer lib APIs, so don't expect frequent
major updates on library versions, but was struggling to keep it as much as
possible tho. I'm checking the final test results, and thus, planning to
release 1.11.1 within a week or so. In this release, I'm seeing that
it requires to bump revision like libf2fs-5.1.0, and libf2fs-format-4.1.0.

> 
> I was about to send the Debian maintainer of android-libf2fs-utils
> package a ping asking him or her to relink against the latest so
> versions --- libf2fs.so.5 and libf2fs-format.so.4.  But if the next
> release is going to involve a bump of the so versions again, I'll hold
> off requesting a rebuild of the package.
> 
> And if the shared libraries are going to be regularly bumped due to
> incompatible ABI changes, should I recommend the andorid-f2fs-utils to
> statically link instead of link against the f2fs shared libraries?

Yeah, I think that'd be much safer to us for a while, as I expect.

> 
> (I haven't bumped the e2fsprogs so versions in over a decade, but
> that's because I had carefully designed the interfaces to allow for
> backwards compatibility as we added new features to the file system.
> I didn't know if that was part of your plan for f2fs-tools)

Will keep to try on it. :)

Thanks,

> 
> Thanks!!
> 
> 						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
