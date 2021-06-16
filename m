Return-Path: <SRS0=P3Wg=LK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4CC48BE5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Jun 2021 04:10:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FBE611BE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Jun 2021 04:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FBE611BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ltMsf-0003hY-EL; Wed, 16 Jun 2021 04:10:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+ae8989e1668f84a74d37+6506+infradead.org+hch@casper.srs.infradead.org>)
 id 1ltMsV-0003h6-SG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 04:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+hJYay8JR5Szrm3esdkGPPnSrjDyFQjXCxZ0d9ypRKM=; b=fMvATHEb8/k1MPPfn6nsQu+ewF
 VTPfMPaw+NlE1eTq34CxO6/ludlskZQySXOFUrxuO35GIr161v2GkNB/m1JNvNgTqfezPd6pwr1TU
 HKoTcV8WjWJlxMAxS/jY22atu2c9fl2zhDoP/hmalqkCCmIOkCU9hufOx7oMOZ7Vjkwg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+hJYay8JR5Szrm3esdkGPPnSrjDyFQjXCxZ0d9ypRKM=; b=lL5C97X29MguP9Cl70dxWVqoG5
 G1jm2yVgqHfFV6JzH8HvhQUHYCLR7HWKMrPIxbIgOTuf/yRFRqjRl4YsShdiK3/3CXpirzjCEnFzF
 dfGuOor12yazxXuapG1zOuosaAzjfbNJiOXtV6g3Vx9m4EvO0eoBrMViU6ZoxLBWdvEQ=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ltMsE-0003L9-Fh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 04:10:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+hJYay8JR5Szrm3esdkGPPnSrjDyFQjXCxZ0d9ypRKM=; b=n0s17+QbCeywB7tT55kKef7453
 IRB44+PDdtgICy2G0YMcftFVm199pSyAdpJGLKekmgdDBZ6XuffMxQMX36hOLOXe28uAJsKKfDKko
 FgkgOoBPpT+eEqyG+epXsLvvuUqfdJL6RVTgTnRfMA2AIuN7I3jFsrqBQ2x/0gbyZD/CPxj1eKJxL
 ElbswIIRhKlBbbiBiG7O14d0EA2iO3poptdiTrI+Td/PVfTWXo8LEs20orcm9ZuI+/Fcdk16HSbDc
 KC3M91MxPVUHrVsFUE3HxZt9AdJ5Oad68ELIZPI7ZVTOuGQ1zl3x3qOXLlmEGjVVvc2qeqW5fFSBn
 II4beYog==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1ltMrV-007ZmS-MR; Wed, 16 Jun 2021 04:09:11 +0000
Date: Wed, 16 Jun 2021 05:09:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YMl5Zf1+Q7fop4Qj@infradead.org>
References: <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu> <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
 <YJoJp1FnHxyQc9/2@infradead.org>
 <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
 <87zgw7izf8.fsf@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zgw7izf8.fsf@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1ltMsE-0003L9-Fh
Subject: Re: [f2fs-dev] [PATCH v8 4/4] fs: unicode: Add utf8 module and a
 unicode layer
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
Cc: ebiggers@kernel.org, Theodore Ts'o <tytso@mit.edu>, drosen@google.com,
 ebiggers@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 kernel@collabora.com, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 02, 2021 at 08:07:07PM -0400, Gabriel Krisman Bertazi wrote:
> I wasn't going to really oppose it from being a firmware but this
> detail, if required, makes the whole firmware idea more awkward.  If the
> whole reason to make it a firmware is to avoid the module boilerplate,
> this is just different boilerplate.  Once again, I don't know about
> precedent of kernel data as a module, and there is the problem with
> Makefile rules to install this stuff, that I mentioned.
> 
> We know we can get rid of the static call stuff already, since we likely
> won't support more encodings anyway, so that would simplify a lot the
> module specific code.

Well, another thing we can do is a data-only module.  That is a module
that just contains the tables, with the core code doing a symbol_get
on them.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
