Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C4C35646
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:31:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C087724650;
	Fri, 21 Feb 2020 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z5htg+Pl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Th8RF3e6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WC40/Nnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087724650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j5C9A-0005GZ-DM; Fri, 21 Feb 2020 17:31:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b8b070cac54c30a96dd5+6025+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j5C98-0005GQ-Ia
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pDx3LdN9kmcpyyosCuGFps+kdXETL/vBLPKf49LLrtA=; b=Z5htg+PlCRx8UbLQ12fUtUDEB6
 UwTCAIBNoVdDRC3NIzMPO4FNvhZX+7wAboQjThJP2O5Y59UBvJPcwgFRZn0AFK+tEwuYcAR9Bc8hp
 hJ8h2LJjcZ7IZNgXf48fBcLRNX8IJv60FqaSetqN3WIuw8rpHCwvOEIn7Lm1L9c+9PYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pDx3LdN9kmcpyyosCuGFps+kdXETL/vBLPKf49LLrtA=; b=Th8RF3e692pgjyaHzh0/Ftz/4G
 qv9AIiFtVHSuUbaroKgHR579qz/zJoA5SW/5IILJ2oMspisx+TG/dlrXK6b4j9tR3fjhBVvizlzTf
 +JyiWMfSscM7lMcG/ozGnXgS2dA7IsA0Ba3SiP3AdklLqDGh1nK36H5X0CCcAJhSoiuU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j5C97-0095vS-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=pDx3LdN9kmcpyyosCuGFps+kdXETL/vBLPKf49LLrtA=; b=WC40/Nnwv876skL3b390tcpGP9
 HgE+oXYuSaMQgz5W07wW6Rr47DqxNlyAwrKb3/uPmOsWKnNnVtYE8Xz8DSZGJ3C99Qd3sG6xfF9Ii
 XuBMvXiTK1amcjIiiq2kC4rs8ffrhGi/JO8Nwy+/88DvBOdifqDnueyctDpfPXJkr2EnAO3y6bwzj
 3Y/4M719cDTpkqdmkX6WdGI/x1/3C/oubQQKuEl2mpHoXbl/1syPu+YXJIUiGA/PikgQ4hmyESHN5
 9PXCOS8FkY3cPGe3AZJ4n/D8zsxqyOfQG7Y2RkV342MYTYvMNg5nastL2NES3sKMkOr41xuj8BRQJ
 POSqE2XA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5C90-0001Qd-83; Fri, 21 Feb 2020 17:31:18 +0000
Date: Fri, 21 Feb 2020 09:31:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200221173118.GA30670@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-2-satyat@google.com>
 <20200221170434.GA438@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200221170434.GA438@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j5C97-0095vS-Cy
Subject: Re: [f2fs-dev] [PATCH v7 1/9] block: Keyslot Manager for Inline
 Encryption
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Feb 21, 2020 at 09:04:34AM -0800, Christoph Hellwig wrote:
> Given that blk_ksm_get_slot_for_key returns a signed keyslot that
> can return errors, and the only callers stores it in a signed variable
> I think this function should take a signed slot as well, and the check
> for a non-negative slot should be moved here from the only caller.

Actually looking over the code again I think it might be better to
return only the error code (and that might actually be a blk_status_t),
and then use an argument to return a pointer to the actual struct
keyslot.  That gives us much easier to understand code and better
type safety.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
