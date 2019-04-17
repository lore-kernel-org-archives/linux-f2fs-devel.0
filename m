From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 1/5] fscrypt: clean up and improve dentry
 revalidation
Date: Wed, 17 Apr 2019 09:50:15 -0400
Message-ID: <20190417135015.GA4686@mit.edu>
References: <20190320183913.12686-1-ebiggers@kernel.org>
 <20190320183913.12686-2-ebiggers@kernel.org>
 <20190416230840.GB14623@mit.edu> <20190417001041.GA18090@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@mit.edu>) id 1hGkxV-0006nv-Ib
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 13:50:41 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGkxT-00BOHv-HI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 13:50:41 +0000
Content-Disposition: inline
In-Reply-To: <20190417001041.GA18090@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org, Sarthak Kukreti <sarthakkukreti@chromium.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

On Tue, Apr 16, 2019 at 05:10:42PM -0700, Eric Biggers wrote:
> 
> Hi Ted, I assumed you resolved the conflict with "fscrypt: use READ_ONCE() to
> access ->i_crypt_info"?  The code in fscrypt_d_revalidate() should be:
> 
>         dir = dget_parent(dentry);
>         err = fscrypt_get_encryption_info(d_inode(dir));
>         valid = !fscrypt_has_encryption_key(d_inode(dir));
>         dput(dir);

Yes, I did notice the patch conflict.  Thanks for confirming the
correct resolution!

						- Ted
