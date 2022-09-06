Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D9C38145
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Sep 2022 08:11:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oVTgI-0003wo-R4;
	Tue, 06 Sep 2022 08:11:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+3c9dadc9e27e1b9c7a6f+6953+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1oVTgB-0003wX-0D for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 08:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IBguVdIqXo9rH+4w+54QJvKBgk
 QdxSXU21zPpI4pk2nHQ3iPugQNw/68u9I8mA0SrSsWOv72hbTgr/53uifor8WoFHgXG1n8LqRaLOl
 4J4E+LcW6pP1+hZvvv+0TSRWGTwyFO7PSzJ/iiL78U7KKkgM1GAEsThvZcSdiPngB1jE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Huhy62ZtkHDGc0J0Af812VbFTz
 YZC4z1VLli9874mLoYafa2RBcP+dKBheEi+Rjxucxmoo4UDkOf4QYwU413ozhPICk++9a7T3U7wYg
 W38Ebpk+Uw5YYO8tukdg81ZrE5Paigpq/oq3iIp7KWHUaS1Qr1Xxrt2edkWB3ptSq0bk=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oVTgA-0003qZ-Fe for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Sep 2022 08:11:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BaxZ4xrTAfmnQpu1FWHDq9b/Q4
 4NQW8r6DzhULWWFTzIQyFtOoRDl/gd6W/UDwqJQWEglq+NEr6ZZKf+lqsn0Sx6dhduKMacJOrehFs
 Uye5wOnh0Fw0In2tAQgMLT7jOxMl8o369S7uUmDszvl4/EqRRChb9guHaexaCXBT9OhiaEdWIDosu
 bYKDx2E8q6blOVG7Hw4nEYXm2u6zJSiqf9Z+GIDMzKP8wWVfNBQe37hZ1j27AI742w9JjywX/Ci+Z
 bcLH0Eb2J49C9nGimwys8W4wpf1BhBcAQI6tIKOUi2HT8ran79+4cVe5f1cLrRXAqADOAr79gDVdH
 Vun/yftA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oVTg0-00B7mp-Sw; Tue, 06 Sep 2022 08:11:20 +0000
Date: Tue, 6 Sep 2022 01:11:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YxcAqLtDZix6/Zxw@infradead.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <20220827065851.135710-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-9-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1oVTgA-0003qZ-Fe
Subject: Re: [f2fs-dev] [PATCH v5 8/8] xfs: support STATX_DIOALIGN
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
