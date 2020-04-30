Return-Path: <SRS0=phsH=6O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C283C4724C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Apr 2020 22:14:14 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4335820870
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Apr 2020 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XkO+Kfmg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="G0OB0cI2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xh5T5/zf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jUHRd-0003ry-OC; Thu, 30 Apr 2020 22:14:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>)
 id 1jUHRb-0003rc-Ms; Thu, 30 Apr 2020 22:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd0ZsvJx0qN41jGJdx6Q3uDOBTPr2hBuuON/tmj1OPE=; b=XkO+KfmgWhS43hjIylO9KapXmo
 UbktEFIpG7c2lJBIYPNrskcD6GFcD73ioZhg6GHgg4MeN2l3ei9B18bcHI+JXkSBMf8Jbeaa1lnNV
 s8lcMnzE/oMQ2C5A4+wGSrSTdqRT3dw4Dw2HB9NpEE5Z7IwkEeIOfKD8L343u8wZ0AvU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd0ZsvJx0qN41jGJdx6Q3uDOBTPr2hBuuON/tmj1OPE=; b=G0OB0cI2KfPJ6ezMCBUjva6a9X
 PFqv77HlBO+uTPH2KHWTjnm0vLGfvbdCaUjVmsY/1pV5hsyOPQhvHO4n0khiEkzpKRtzu2SP+2g1a
 7YT7IwopL3BY2vtJ0kfxhfr2cYiJ1e4MQTk0pspoMfcDhQHewREH+25OqvmsTng0aTqo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jUHRa-003ngT-G8; Thu, 30 Apr 2020 22:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bd0ZsvJx0qN41jGJdx6Q3uDOBTPr2hBuuON/tmj1OPE=; b=Xh5T5/zf36Iun9lfkNlEeXo/27
 qpj6KB4345/Cc/m+7HWNU07yHSitTsHNxf43w29pLdFOLHOfVTYjI9tDCKGec6cEk83PJ5GqWyrFw
 xCVrZDz49/b0wB7Yapm/GbhfIo0w0D60cKkNHaoxbLCv70va07R3hB3AxdrLrli8dB87fDS0Ndm9j
 m+USiBB+G6dkvHAgLi3/Sy2qxmHFNVeKf9RAg+FPui7Hgtq0Ig17TaGN1/AGUg4WEKCDRMHpCrK7u
 9rIqjC7QpANlp3+ie8aKQDzn2D4NAtlZhS85GUMY3G9CNKyyxd/3mIlLD0DRHnazAYqhFC6STfv7G
 vA7SVRlQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jUHR4-0007zt-IY; Thu, 30 Apr 2020 22:13:38 +0000
Date: Thu, 30 Apr 2020 15:13:38 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <20200430221338.GY29705@bombadil.infradead.org>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
X-Headers-End: 1jUHRa-003ngT-G8
Subject: Re: [f2fs-dev] [RFC PATCH V2 1/9] include/linux/pagemap.h:
 introduce attach/clear_page_private
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
Cc: Martin Brandenburg <martin@omnibond.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, david@fromorbit.com,
 Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 Mike Marshall <hubcap@omnibond.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, Chris Mason <clm@fb.com>,
 hch@infradead.org, devel@lists.orangefs.org,
 Josef Bacik <josef@toxicpanda.com>, linux-raid@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Anton Altaparmakov <anton@tuxera.com>, Andreas Dilger <adilger@dilger.ca>,
 Yang Shi <yang.shi@linux.alibaba.com>,
 William Kucharski <william.kucharski@oracle.com>,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <guro@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 30, 2020 at 11:44:42PM +0200, Guoqing Jiang wrote:
> +/**
> + * attach_page_private - attach data to page's private field and set PG_private.
> + * @page: page to be attached and set flag.
> + * @data: data to attach to page's private field.
> + *
> + * Need to take reference as mm.h said "Setting PG_private should also increment
> + * the refcount".
> + */

I don't think this will read well when added to the API documentation.
Try this:

/**
 * attach_page_private - Attach private data to a page.
 * @page: Page to attach data to.
 * @data: Data to attach to page.
 *
 * Attaching private data to a page increments the page's reference count.
 * The data must be detached before the page will be freed.
 */

> +/**
> + * clear_page_private - clear page's private field and PG_private.
> + * @page: page to be cleared.
> + *
> + * The counterpart function of attach_page_private.
> + * Return: private data of page or NULL if page doesn't have private data.
> + */

Seems to me that the opposite of "attach" is "detach", not "clear".

/**
 * detach_page_private - Detach private data from a page.
 * @page: Page to detach data from.
 *
 * Removes the data that was previously attached to the page and decrements
 * the refcount on the page.
 *
 * Return: Data that was attached to the page.
 */


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
