Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5F5E677F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 Nov 2024 10:20:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t7BEp-0007ki-SE;
	Sat, 02 Nov 2024 10:20:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <herbert@gondor.apana.org.au>) id 1t7BEn-0007kc-Pm
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Nov 2024 10:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=; b=bz46/Ov/+C8O1ITLL+nvWnfXn8
 UFJ4OppsYehNQ4rfZKaymrDYkAOay31nxyymAFXekmhXbC/+KrhCbhcWo//0V89QcRMD+u1Ix8qhB
 82PhAa6+HOeSYfsxzmpIaodClS0Qt2jcHbuaX/ABxOuhmAolbhQhx23+di1FSxyZ/Ce4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=; b=G+w5a2yszjmN+Au57xvYZwdi36
 RckTbjzOhodyWzh5kZLjE5Kg2qjHI9JjSl1r7JId1lmGcJSnOD13ChF4P5F+tHpVjkg5MOaNNDFuU
 Su4xfbhcZywt1p2xl8Nf2GUFuqeCNUfA7I8i1WTVg/JS1REoC3SpgtZV5/f5n6DZ5b5Y=;
Received: from abb.hmeau.com ([144.6.53.87])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t7BEm-0004wl-Ij for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 Nov 2024 10:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yYa+7XoJuDdb76oEmaiyHNPbnto6CbOy5cbqLih549g=; b=IxqSkCyyTRJ8QPfyWdRdr2qHrJ
 tpnjvWqxXTt+J7vxVmfkjrXd/rdKT+0RFdwGzbsRsMR9EdmzQEnFrsAgTnaI9+pdPBY3Pn9re79Nj
 57c2proTZGddCmA7w8N1JXHF1QdjpqJ+rO1URQev5azBEyB5hCBbYGnbLrSwTrfwTX1ksXWj0DUCf
 yuXLmD7dk6/d8YNZezbMYQ6VdXKIYeLQYq1Pq312XFyr1DfhbY4I3pSC7QOr5wrJ+HBrserJJF9gW
 0q+8FZncsHy0y1xio+hERsUI6SlHqDVBhozBkFMWrc3INF748cH6QiBntZMGgC5ZBSYXHEMi51PKW
 hRrho1rQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1t7BEX-00Dy0V-01; Sat, 02 Nov 2024 18:19:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Sat, 02 Nov 2024 18:19:52 +0800
Date: Sat, 2 Nov 2024 18:19:52 +0800
To: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
X-Headers-End: 1t7BEm-0004wl-Ij
Subject: Re: [f2fs-dev] [PATCH v2 04/18] crypto: crc32 - don't unnecessarily
 register arch algorithms
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
From: Herbert Xu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-ext4@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Nov 02, 2024 at 10:58:53AM +0100, Ard Biesheuvel wrote:
>
> At least btrfs supports a variety of checksums/hashes (crc32c, xxhash,
> sha) via the shash API.

OK, given that btrfs is still doing this, I think we should still
register crc32c-arch conditionally.  Having it point to crc32c-generic
is just confusing (at least if you use btrfs).

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
