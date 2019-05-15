From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] f2fs-tools: improve filename printing
Date: Wed, 15 May 2019 08:49:44 -0700
Message-ID: <20190515154943.GB21903@sol.localdomain>
References: <20190424175909.71430-1-ebiggers@kernel.org>
 <bc18ee1a-8c31-fe76-fd13-a401ce203095@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hQwAC-0006sn-LY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 15:49:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hQwAB-004ulv-D4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 15:49:52 +0000
Content-Disposition: inline
In-Reply-To: <bc18ee1a-8c31-fe76-fd13-a401ce203095@huawei.com>
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

On Sun, Apr 28, 2019 at 02:25:37PM +0800, Chao Yu wrote:
> On 2019/4/25 1:59, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > - Make buffers for pretty-printed filenames 341 bytes long, long enough
> >   for 255 (NAME_MAX) base64-encoded bytes.  Then print encrypted
> >   filenames in full, base64-encoded.  This will be useful for tests I'm
> >   writing which verify the correct ciphertext is stored on-disk.
> > 
> > - Rename convert_encrypted_name() to pretty_print_filename(), to make it
> >   clear that it handles unencrypted names too.  Also make the output
> >   'char' rather than 'unsigned char', as it's for printing; and remove
> >   the unnecessary return value.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 

Hi Jaegeuk, are you planning to apply this patch?

Thanks,

- Eric
