From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] add cotnfigure option --with-root-libdir
Date: Wed, 29 Aug 2018 19:51:41 -0400
Message-ID: <20180829235141.GL19128@thunk.org>
References: <20180820030407.13225-1-tytso@mit.edu>
 <20180827155114.GG2311@thunk.org>
 <20180827165744.GB74162@jaegeuk-macbookpro.roam.corp.google.com>
 <20180827235619.GA2304@thunk.org>
 <20180828071202.GA29049@jaegeuk-macbookpro.roam.corp.google.com>
 <20180828142511.GA19128@thunk.org>
 <20180828165944.GA62482@jaegeuk-macbookpro.roam.corp.google.com>
 <20180829031040.GE19128@thunk.org>
 <20180829210455.GA77879@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fvEuW-0005KS-SX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 04:50:24 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvEuU-002v4P-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 04:50:24 +0000
Content-Disposition: inline
In-Reply-To: <20180829210455.GA77879@jaegeuk-macbookpro.roam.corp.google.com>
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

On Wed, Aug 29, 2018 at 02:04:55PM -0700, Jaegeuk Kim wrote:
> Thank you so much for kind explanation. This is really awesome especially for
> newbies like me. This gives answers to me for all my own stupid questions like
> why I need to investigate all the lib changes in order to determine bumping
> current/revision/age numbers or not.
> 
> I'd definitely like to follow this rule to avoid any verion changes later, as
> I expect the next release will be the last major update. For dependency parts,
> I'll study and practice them for a while.

If you are going to be making one less major update, this is the
perfect time to make sure that data structures are allocated by the
library, and are (ideally) opaque to the calling application (so they
only manipulate structure poitners).  That is, the structure
definition is not exposed in the public header file, and you use
accessor functions to set and get fields in the structure.

If you can't do that for all data structures, if you can do that with
your primary data structure that's going to make your life much easier
in the long term.  For ext2fs, that's the file systme handle.  It's
created by ext2fs_open(), and it's passed to all other library
functions as the first argument.

The other thing you might want to consider doing is adding a magic
number to the beginning of each structure.  That way you can tell if
the wrong structure gets passed to a library.  It's also helpful for
doing the equivalent of subclassing in C.

This is how we do it in libext2fs --- we use com_err to define the
magic numbers:

	error_table ext2

ec	EXT2_ET_BASE,
	"EXT2FS Library version @E2FSPROGS_VERSION@"

ec	EXT2_ET_MAGIC_EXT2FS_FILSYS,
	"Wrong magic number for ext2_filsys structure"

ec	EXT2_ET_MAGIC_BADBLOCKS_LIST,
	"Wrong magic number for badblocks_list structure"
	...

And then every single structure starts like so:

struct struct_ext2_filsys {
	errcode_t			magic;
	...

struct ext2_struct_inode_scan {
	errcode_t		magic;
	...

And then before we use any pointer we do this:

	if (file->magic != EXT2_ET_MAGIC_EXT2_FILE)
		return EXT2_ET_MAGIC_EXT2_FILE;

Anyway, you don't have to do any of this, but if you're thinking about
making a big major version number bump, this is a great opportunity to
do some of these things.

> BTW, can I archive this like in f2fs-tools/VERSIONING?

Sure, feel free!

					- Ted

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
