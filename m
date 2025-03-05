Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A709C19F32
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:47:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tpq1e-0000vS-2t;
	Wed, 05 Mar 2025 14:47:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e9459c3471db86f08d91+7864+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1tpq1X-0000vB-ED for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Mar 2025 14:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NQiHiWBYuLEjIBCwbtDawYA0OWXgtE0nlWIHtE9qJ/A=; b=ELvk2Dh5Bmg7v1J9405gkdkPn7
 AIT0CnJqGfEBK5fBH39UNJqvfLxvrH8rvt0aSeavCGVSr2fAdj2KLmNby7wQS6A6PwkQ2plNl+wck
 4RiIww0uGbwYAMpV2UQ2INXpFgAJxDb1F8Jw/WNP+tTnRKfRG/ReC/TkkbHgMKkFdyU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NQiHiWBYuLEjIBCwbtDawYA0OWXgtE0nlWIHtE9qJ/A=; b=ZC1L8HOVJv4ZRjCjrBNTzONaud
 x7Z7VFhD5puks3SYJkoVbzPf1RT7+fa9Ofzjs/VDWshAwzAoG+GiH1grCOCBx43xnVawDESg7jw12
 D5cjh2KUukQHaJncLXZ5lnXFFyTBiUKKfpxZG7x+XnZ3ifldc25jcmorRPb0B3kMPJMY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tpq1V-0006ET-Ai for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Mar 2025 14:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NQiHiWBYuLEjIBCwbtDawYA0OWXgtE0nlWIHtE9qJ/A=; b=MU/UkorEJtYCTL/69PWWpAlTQS
 lJT1aQCWoVw57XnjyZJ0/P/XqTFLRedcJCU/f1ph8GVU+cS34ocBKwUyk7YDkboGQ1zN1L0hJ23+n
 AxGrg6p5FVoU6pKjYlwxPQAqU8cSdK/N1A1JnJouGIYJEhw7/qa2ds+gGhv59Fhkvr986eXOI8CWU
 ckgI4iliDeVkHKL8ZTJeK4hKJDMx+Mq6QwYwIgHV3WVVEc8Mol+cUeB9v+P+iolg18BqA7S/Qp5Zk
 58aBWO3aRzO0sinW0PiM/q/9BZMU+1+jCAH0mR6wOp6E01O9xWbHa3+jkcMaB1A2bKkjezmhmQ1/h
 CboY8POA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tpq1K-00000008Or0-3uVK; Wed, 05 Mar 2025 14:46:50 +0000
Date: Wed, 5 Mar 2025 06:46:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <Z8hj2g_fj1zH1t_m@infradead.org>
References: <20250303034606.1355224-1-chao@kernel.org>
 <20250303230644.GA3695685@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250303230644.GA3695685@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1tpq1V-0006ET-Ai
Subject: Re: [f2fs-dev] [PATCH] f2fs: support F2FS_NOLINEAR_LOOKUP_FL
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
Cc: linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Mar 03, 2025 at 11:06:44PM +0000, Eric Biggers wrote:
> > +/* used for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS */
> > +enum {
> > +	F2FS_NOLINEAR_LOOKUP_FLAG = 0x08000000,
> > +};
> 
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS are not filesystem-specific, and the
> supported flags are declared in include/uapi/linux/fs.h.  You can't just
> randomly give an unused bit a filesystem specific meaning.

Eww, yes.  This needs to be reverted ASAP.

And I'd like to repeat my reminder that we need to stop file systems
(and f2fs is particularly bad for this) to stop just adding random
uapis without review from linux-fsdevel and linux-api.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
