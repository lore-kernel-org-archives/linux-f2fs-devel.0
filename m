Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466D1C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tarcJnsczZ4fEqnEWMJ0XVGwSMUR7Wy5Wl8XL08AFU0=; b=JEzCG0NRVGu99Oc+J9/obQ6ubK
	wjipTrPjTH7sdQ013DzFdzLxXziRH44sSNCxbVoQw8yEuDh4Ex2cUoCi52CcAbWz8RHn6xuL8++81
	Bpsqi0uYJXdxtjKuCMQUkBKg5g04zEiWOFy8uB1XSeu0pOa9Naew2vvyaDlv0PPDHPLg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wkl8r-0002kt-GZ;
	Fri, 17 Jul 2026 16:10:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wkl8q-0002ke-4u
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:10:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pIUW+eqslxS6fL0da7s3Tey79O3lS7y8FN9jNAzbHUI=; b=muo8pqmAnQA60n0LezA4QJscbF
 kywvULMsXyQ0ASfma/wsob7RtSigTSohsu5cSnBSaxZ43UZwRyZi/FEw3eXcHw2QjsX/U8GZKwD6y
 6R/ZfkZUMYOFfIDcAiy6BgB3JccwB1zmGrEF8ZePHefGUaLbREVsUKrawDY8H1tB/xuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pIUW+eqslxS6fL0da7s3Tey79O3lS7y8FN9jNAzbHUI=; b=W4VIWJ8h5yse2ctVCmuFkskl+o
 UaG5MmoK7jfFAGIHX0ySzg4dVhKff9rklVMPGcAYTk0NYbOqlvNSjgEmOCtKSIZww41hcPUlUw+Mv
 Dr56DXNwLqwxhgOg/p8L7/TW95C7a6XCS0OS5CwtcHUBfkTv7ZGPd0OFuRRLQW++WoCw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkl8q-0001il-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:10:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7CCA60A59;
 Fri, 17 Jul 2026 16:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD361F000E9;
 Fri, 17 Jul 2026 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784304613;
 bh=pIUW+eqslxS6fL0da7s3Tey79O3lS7y8FN9jNAzbHUI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nks8VVps0U/b3zaewmXKNfqgQOMbquU7Es70xmRcf4GzWPzxGe1iL+bHpug9ag8ix
 q+36dKdX5LFmaH1p6qvDLg2kYEM3yf7LtV5gapPaLs/YLAOQitXDGVs6HK9Bk3WBpg
 GSBnHPzP1+V6ILFJmoFlQx3nUiocuphYiTrJoupT02pYvYmWLzjs2cPIOgFFtr6BYN
 hAyJv3gVq0QBxFJukK7aV9wFLxDb9MLOEphgLzE4oASCSUPxNoDVcaiIIOWFlYh+hN
 q4s8sPfDZAjR3XJfWCewHkbdoMfuBkfuYVg/qbPKI83XQDUcJshIuU8jpXDYoxMiqy
 t16QO366QOEbQ==
Date: Fri, 17 Jul 2026 09:10:08 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260717161008.GB2046@quark>
References: <20260713023708.9245-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260713023708.9245-1-ebiggers@kernel.org>
X-Headers-End: 1wkl8q-0001il-Gm
Subject: Re: [f2fs-dev] [PATCH v3 00/17] fscrypt: Standardize on blk-crypto
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 12, 2026 at 10:36:51PM -0400, Eric Biggers wrote:
>   ext4: Remove fs-layer file contents en/decryption code
>   ext4: Make ext4_bio_write_folio() return void
>   ext4: Further de-generalize the bio postprocessing code
>   f2fs: Remove fs-layer file contents en/decryption code
>   fs/buffer: Remove fs-layer decryption code

Could we get acks from the ext4 and f2fs maintainers on these?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
