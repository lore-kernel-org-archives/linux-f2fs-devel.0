Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF6CE77188
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jan 2025 06:24:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tYJIp-00036s-9Z;
	Thu, 16 Jan 2025 06:24:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+ab4431c7548323339812+7816+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1tYJIn-00036l-TF for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jan 2025 06:24:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/iG6R5K0Z2xKca55Hx2rIbmMDwC2MV6uVlIzu7zRCWI=; b=FoJhRqYQzkXl1j/G/D6kvLr2Wn
 pqJo7FTFWDvNYCwj1//mD5fMmFFHAhp7FxEq9ekaEBH0zMz4S+d6nvvoqUPZW11Yu1RWSVsah7tNu
 T7tf4tkpfmqy57TkQIIiJyGrcJdt/6JAC92vzfKrFzd9k+EZfQHegt99iI6JsAIaxDxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/iG6R5K0Z2xKca55Hx2rIbmMDwC2MV6uVlIzu7zRCWI=; b=j9LMrkB1bVMSPDwuJ7Vf/TyvSU
 Dd/7PVHLJC2XCEuzA5+TW5UN+akZLvxMgSKf6nC4qvWXamSbZwpwxuoZGPSwPzDDZ7r3jVdY3R1RC
 gBnNZanfvHIhi438JNnzTIiiItUfxRmZT5xWwoWArF+ruJjcU9IxJ29nyInvmZ9PHzpk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tYJIm-0002d5-Ks for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Jan 2025 06:24:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/iG6R5K0Z2xKca55Hx2rIbmMDwC2MV6uVlIzu7zRCWI=; b=Ymjb+7BYVxoCw+M/sNN4wdisbP
 ayhJHEGpjmyd6H684XMLOR9R9shcxsCHehwmag5PviSwAT2uew33gQ9miFcb5KJr/hjixumDomthP
 zFvVxJSu1+p4TXuB1ohV9dKknfbxghWuyTtCphYjOR8q3INr6I2PLNXVWlC1j1FaXOhVYdK9FzrRg
 AGIjb3F8Fs7e7YX85URRNHWT5R2u8uLbBCDggD4wloFQeEQ6mvJ5d2XMRiN1CSUMITiyLmuKFUkdJ
 2JSIQl31pVG/MwneEGGO6/jMpz1ry7EjUKymoiIHKUu3iVgLItPGQoPZRGS+/dsY+vtAvlxwlJ7/U
 lUO5COIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYJIg-0000000Dwbn-3UBD; Thu, 16 Jan 2025 06:24:18 +0000
Date: Wed, 15 Jan 2025 22:24:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <Z4imEs-Se-VWcpBG@infradead.org>
References: <20250115221814.1920703-1-jaegeuk@kernel.org>
 <20250115221814.1920703-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250115221814.1920703-2-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1tYJIm-0002d5-Ks
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: register inodes which is able to
 donate pages
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-man@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 15, 2025 at 10:16:51PM +0000, Jaegeuk Kim wrote:
> This patch introduces an inode list to keep the page cache ranges that users
> can donate pages together.
> 
>  #define F2FS_IOC_DONATE_RANGE		_IOW(F2FS_IOCTL_MAGIC, 27,	\
> 						struct f2fs_donate_range)
>  struct f2fs_donate_range {
> 	__u64 start;
> 	__u64 len;
>  };

> e.g., ioctl(F2FS_IOC_DONATE_RANGE, &range);

This is not a very good description.  "donate" here seems to basically
mean a invalidate_inode_pages2_range.  Which is a strange use of the
word.  what are the use cases?  Why is this queued up to a thread and
not done inline?  Why is this in f2fs and not in common code.

I also which file systems wouldn't just add random fs specific ioctls
all the time without any kinds of discussion of the API.  f2fs is by
far the worst offender there, but not the only one.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
