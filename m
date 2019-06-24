Return-Path: <SRS0=dEys=UX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2601C43613
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:46:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB3B208E4;
	Mon, 24 Jun 2019 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LoobLcUa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bhgt7Dvr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rsFPGs5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB3B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hfPIE-0003nT-1h; Mon, 24 Jun 2019 13:45:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+84882ec255bc51113d1a+5783+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1hfPIB-0003mn-Op
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 13:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BUnOoXsQ8vI3qS3szXEDs2fAZTjGRFJUpiAXARiLAvk=; b=LoobLcUaXio8eFy5CwGoNmmn2Z
 C7cbuzgwbZVjGrg4AfZV+EYCjt8pgGz3lyL8EHC8QdcsE+w5fA3+06uC2CxWoFrZrqAYvt0xOSjPs
 gWy4irfe1zxXOo7BX3q1Ib8D+Qjz/s0IsqIEboX7+4h7RcJ12xgbPaML5hho64yOEXx4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BUnOoXsQ8vI3qS3szXEDs2fAZTjGRFJUpiAXARiLAvk=; b=bhgt7DvrzEXNBmvXYpV61lu0a2
 8KJDHuondxWOgem3i8SucaK7Saqs8niNPLOLzS8n+WZA9pt22yUV5woOhPu/V2w3eW/Wrr1oNETbG
 L7re8vkD+EtIPFicvvU9A+jayiMkJoXZMNnJZXsgHoy1XaSl52hJyZqFja38dMv2EIMQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hfPIF-00C6x6-V8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jun 2019 13:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BUnOoXsQ8vI3qS3szXEDs2fAZTjGRFJUpiAXARiLAvk=; b=rsFPGs5h0yaaPiZwsWI3YkZL0
 S+eeHilaw5DqP3wRRFWwZczhNJkLGwjW8cK+fSi6bLTk71+OpS9LOMT/IcLNuwNwKOHIlsH0AZXRV
 zp8B1CHL4OFFAvvEx1YSTotSJV4sn0b5E80ZQzE2PJ7mgIjh8Lhxl3aKjU1eL49qXQhkM5CBhsRUN
 uofWzESi8sDOrxFtRGGZ6INRqnHpRq7ZFcPTdRRBZxMQME15tZkfDt21uOE0+ngd3NrQyfEbYuo/W
 psMsI2feNWLlcfsPV8TlxeSlvX9EjWhfJRQlNsR0rIrylFsw7qRwqR4jjkbIfwCapQLe/a9Uob4IR
 HP0/KGPIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hfOvl-00074F-FX; Mon, 24 Jun 2019 13:22:45 +0000
Date: Mon, 24 Jun 2019 06:22:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190624132245.GA12316@infradead.org>
References: <20190621180124.82842-1-jaegeuk@kernel.org>
 <622f5e04-3781-d49a-d65d-a7c244389cb3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <622f5e04-3781-d49a-d65d-a7c244389cb3@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1hfPIF-00C6x6-V8
Subject: Re: [f2fs-dev] [PATCH] f2fs: add wsync_mode for sysfs entry
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Moreover if it makes sense it should be a generic setting.  Please
Cc Jens who added REQ_BACKGROUND and linux-mm to the cc list so that
we can have a good discussion.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
