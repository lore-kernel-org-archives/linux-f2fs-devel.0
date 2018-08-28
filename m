From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] add configure option --with-root-libdir
Date: Tue, 28 Aug 2018 09:59:44 -0700
Message-ID: <20180828165944.GA62482@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180820030407.13225-1-tytso@mit.edu>
 <20180827155114.GG2311@thunk.org>
 <20180827165744.GB74162@jaegeuk-macbookpro.roam.corp.google.com>
 <20180827235619.GA2304@thunk.org>
 <20180828071202.GA29049@jaegeuk-macbookpro.roam.corp.google.com>
 <20180828142511.GA19128@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fuhLN-0006TM-4H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 16:59:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuhLL-0019HL-9l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 16:59:53 +0000
Content-Disposition: inline
In-Reply-To: <20180828142511.GA19128@thunk.org>
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

On 08/28, Theodore Y. Ts'o wrote:
> On Tue, Aug 28, 2018 at 12:12:02AM -0700, Jaegeuk Kim wrote:
> > 
> > I think f2fs-tools is getting much firmer lib APIs, so don't expect frequent
> > major updates on library versions, but was struggling to keep it as much as
> > possible tho. I'm checking the final test results, and thus, planning to
> > release 1.11.1 within a week or so. In this release, I'm seeing that
> > it requires to bump revision like libf2fs-5.1.0, and libf2fs-format-4.1.0.
> 
> Just checking to be sure --- does 5.1.0 mean that that were no changes
> to interfaces that were already present in 5.0.0, but there are new
> interfaces added?  That's what a minor version bump generally means,
> but I just want to be sure.

Ah, probably I misunderstood the below?

https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html

I understood that, if there is no interface change but some implementation
changes, I need to bump revision. If new interface is added, for example, I
need to bump current while revision=0 and age++.

Please correct me, if I'm going in wrong way.

> 
> Thanks,
> 
> 						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
