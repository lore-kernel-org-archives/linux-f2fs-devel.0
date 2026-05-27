Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F7CD5BD1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 03:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HEnyHJNaDGPsXc1OLpnpPwwHhZ8YDQ7UgWxuQ2uAB+4=; b=IPBcFHpGWg4lnDwvbJ9DEPw2xH
	aNEHtLu8F2BCbdTm54NOtBC1/SWysV76GVWeG81LSeMUAZdOQegqu4o5LWe9OFA5dTsIRHF0rZD8x
	AzsAh9ZYB4Ww1iuW91m9EpR8TrRM5bYl572L1cbIGbdHhhsYyxdLEzS3kjejp4ovoM2M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS4z9-0001gR-Nf;
	Wed, 27 May 2026 03:31:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wS4z7-0001gK-Dz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 03:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FEJmjXL2EjatPDpj2uMZTIF3mYzVfl1EpI149sPwX1s=; b=SniaaPLeKPHVk++p28vwugok7B
 s8XDKA/mdS7Ap5K93PokPHQaMPXe55+Zmi6w7lgbKkA2n7OeXJmbkkle6QVN1d8O0dx62H8KrIA88
 lK5oVnCBrpVaLiQQoTIVLd+6Pszw7hIn4Mz7soQsLxUZ2mE4vjQ3gNaW596aAAHoBK1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FEJmjXL2EjatPDpj2uMZTIF3mYzVfl1EpI149sPwX1s=; b=jcMYprqWCJLgmDAzEoq9tK+kH8
 XEft6jO5fXmModmeJl3iDDdCdTeAYPngp6pWlKSnTeJOY8S11T98DgtxLopkw3IVW5JZlw4dzYGXP
 zpxNo3ZwL9/epfWCJqwLiMjoQUiIL/DMlNxd5fSx6Rf3W65gaXry6U8qejXPQ0Utp9h8=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS4z5-0001F7-MH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 03:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FEJmjXL2EjatPDpj2uMZTIF3mYzVfl1EpI149sPwX1s=; b=SzjMDLXVYmez33PWlioTW3LcSA
 VYfm8lb0dxWyTtKUEXzvQO58VzLd8uZ4A570kIRTn/C5VAfHG5uTI+QTyZlW3WFEQaocZc+sJe+6w
 Dn2IVlbhEmFmRE4Q8gzB4Ig7t0zyq9SP1CWxblCmLyGSyJ6LdmicLI3DvHwBbc7U1+vL453bCEcml
 GazXwnM826IKjic6pIVVwwD0LZ43zntdbgpySyA+4oyJ+v4d36kiZLysUKYHAu/d4LL1hgzaGEC44
 JXSWfpTjZKZLn53sxEolzqYvOlZCFwNi2cN+dKIPQv0K/ZWMffc3WLR+uBHJ/w9F0+cGeGUBlOttu
 i24CpnPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wS4ys-00000001quo-0A9A;
 Wed, 27 May 2026 03:30:54 +0000
Date: Wed, 27 May 2026 04:30:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <ahZlbQPzTUecMKGU@casper.infradead.org>
References: <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
 <ahZaScMpx19ZLQi4@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahZaScMpx19ZLQi4@google.com>
X-Headers-End: 1wS4z5-0001F7-MH
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, May 27, 2026 at 02:43:21AM +0000, Jaegeuk Kim wrote:
> Thanks for the context. To clarify a piece I missed earlier: the model pages
> are also utilized for inference. Our data shows that larger chunks yield
> higher inference speeds. Consequently, I required high-order pages to optimize
> both read throughput and inference latency. I will halt my current efforts
> and wait for alternative suggestions.

I think your efforts would be best directed towards general support for
large folios in f2fs.  There's still 40+ places in f2fs that use a
struct page, and converting them all to folios would be a great help.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
