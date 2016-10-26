From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] dump/fsck: convert encrypted file name
Date: Wed, 26 Oct 2016 10:18:01 +0900
Message-ID: <20161026011801.GB4173@jaegeuk>
References: <20161024021604.5218-1-shengyong1@huawei.com>
	<580D843A.3000208@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bzCr5-0000EN-O4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Oct 2016 01:18:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bzCr4-0006xI-Qu
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Oct 2016 01:18:11 +0000
Content-Disposition: inline
In-Reply-To: <580D843A.3000208@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On Mon, Oct 24, 2016 at 11:47:06AM +0800, Sheng Yong wrote:
> Hi, Jaegeuk,
> 
> On 10/24/2016 10:16 AM, Sheng Yong wrote:
> > If fscrypt is enabled, we need to convert the encrypted file name before
> > printing it. So let's export convert_encrypted_name for other functions,
> > and make it returns the length of converted string.
> > This patch also changes the parameter of file_is_encrypt to f2fs_inode.
> > 
> [...]
> > -static void convert_encrypted_name(unsigned char *name, int len,
> > +int convert_encrypted_name(unsigned char *name, int len,
> >  				unsigned char *new, int encrypted)
> >  {
> >  	if (!encrypted) {
> >  		memcpy(new, name, len);
> >  		new[len] = 0;
> > -		return;
> > +		return len;
> >  	}
> >  
> >  	*new = '_';
> > -	digest_encode((const char *)name, 24, (char *)new + 1);
> > +	return digest_encode((const char *)name, 24, (char *)new + 1);
> I'm confused about the parameter "24" here. Why it is not the length of
> the cipher text?

It's just to sync with fscrypt_fname_disk_to_usr which uses 24 bytes for the
encrypted name without a key.

> 
> thanks,
> Sheng
> >  }
> [...]
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most 
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
