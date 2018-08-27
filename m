From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] add configure option --with-root-libdir
Date: Mon, 27 Aug 2018 11:51:14 -0400
Message-ID: <20180827155114.GG2311@thunk.org>
References: <20180820030407.13225-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fuJnb-0001bd-1I
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 15:51:27 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuJnY-00FlFq-T1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Aug 2018 15:51:26 +0000
Content-Disposition: inline
In-Reply-To: <20180820030407.13225-1-tytso@mit.edu>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

On Sun, Aug 19, 2018 at 11:04:06PM -0400, Theodore Ts'o wrote:
> This allows the development link libraries to be installed in
> /usr/lib, while the run-libraries are installed in /lib, which is
> required by Debian policy.  This can be done via:
> 
>     configure --prefix=/ --libdir=/usr/lib --with-root-libdir=/lib
> 
> The technique of working around libtool's inflexibility is borrowed
> from util-linux.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Ping?  This is needed (and is applied) for the Debian packaging of
f2fs-tools.  See patch #0001 at:

https://salsa.debian.org/debian/f2fs-tools/tree/master/debian/patches

						- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
