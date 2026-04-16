Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13FDF8D762
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A9YGZrfBAlM+kvlFFFykplBOKRZGXZgsMRh7+S9nbOY=; b=dYBw7mgm98SrAn+ZvOAuH3sVQ0
	83miR49VX90UrLk5uuLe61P4++BvT4nfFjKNgmkAlLyUjf+xiisWv5mJNBzQvBmvEG6a1KcY3GnQ4
	wIIC+gRmXc9iPjAgZvWBfGM0AnIB7PMiV5u9x1z5lMiIx9zlKgsrvNgx8r6GBi+E2os8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDPsI-0000jC-W5;
	Thu, 16 Apr 2026 16:47:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zorro.lang@gmail.com>) id 1wDPsI-0000j5-0H
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 16:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:Date:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=; b=Qw0tqTGhKOcuhUXqUqwmaKgmC9
 kn9Ty2hKtOPbbbrDcDz5zq2ZxJsHgeKKNBYEM3ANtzscKPegaVvCguH/b3VsaZulIXqxW0bAiISIF
 6l+nUxS3BiCgRRHiAmMVur5TFaRzoeKOIBP597Bi6WxrKg3np+BWwCJwwFlyhm1uYQiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :Date:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=; b=TjUAsqC2pWiORpLHilNHIIM/N2
 pudOe01xcqVjyIjeBQx1te2r15snAXmxDBJJ2kCCtmOii3WhzWu7lv22sDpjmrJYQ/uyb0edC5bAj
 Bnt28pG2JvcVcfqwqa99mRyFBbtSoLPJTLBykj8cK5qMQSC45j/b7XvK31PE420gh8Z4=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wDPsH-0002ZU-K7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 16:47:29 +0000
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so49964675ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Apr 2026 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776358039; x=1776962839; darn=lists.sourceforge.net;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=;
 b=eHNl+rQKY+JSrOoJ7RiAUFzxfUJt4ms2XcsRDcvkKj8sfDMRp+8E6MPo81Sw6sYDz6
 i/3t2ifrTkbntbHatZNvmyn1fiM0aYDrDBcOIzlVIEN00NGqWCdyYUmT12oB80n95E92
 hOAgISZb7qtsnlyYDuFujtP1adbmCBhgMao6oeKqcwJoOsDIYKd3uWMfUBd+LWr1w5+h
 5u4/+wMoqi6YkN9IT2p4TEhVVsTFgHfzdloqpLT7E1ipOCgALaiNVsmEMSvBc/6nqnEE
 iC9/EDxRqDGdVqVw2sueElUSjEPuNqfZmoPM5jM1ECq+HljHQ9blKldfg7T/P8VOPo3T
 +I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776358039; x=1776962839;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcIYmGJijp1gql4INlwnF9x0hUWvlgCOIk9cRqzHqwc=;
 b=TIUlD3tM79HHqVlMEuzeB4CQT6ixNo1ogsGXhFxiy3+eX6aqSFIBR4IE8d2MuBbd3+
 1Z4xW3Kpo3NHwpZ2CDbnnuPzCjnkUeSRsI/BxZrDNdARjnuv8PAoJGZsZB9S2/wR4Z+2
 6aJvqxkZPG03m2UXdHZ1DUfIbEeP6/CYRKFRm919ybm4/eTWIFUVm/JTjBbbNnookRNT
 BokSLJwI+Wz5ZX0XiLbvPW0af6KG2Aoe++8NU52bm6jua8h3D6nSJfzbstsLUw3BwT63
 +UaUyCpfe8Z6JLwY1Mn2RQ1U7rAFsex1mmfVdXLoxOy+d8NEERboyTHuMmo0BnYbxM32
 VKig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ny6lXNaM1gzA7CrbsZ0F60pp7Gc5YHfjxl0kZzPjBFT2e45tlIgtjLjCA24jytr3FxqkjbFZupe/w7dlmSk5x@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwtgNX0s5BtUDzjs+40KBDJs7fHyVeCdguxWlFj7jXxqQ0ZRvPN
 HsDzj3YJr1UUkpu1+uH/NyNxUx4nyay7UNOvYsJNUVEQ3ROdIDQt5V7uRS1FypGddHM=
X-Gm-Gg: AeBDieu+jl1Epst1mD8HbPUBVX5o0vOEZ4DDy/l61qv9pZLdN3qf3x5YzgPLJ5zR0CW
 NH3Xn187WZ7sbDKRD8yIf9PNUEAjX+TRtGMg9bm0EkYonHVPPAsPvLhr3KoRnm1kNB5TU0pvKSQ
 1zeQSo7zJQ7Vsg/5dUkNHeUd9hij3S4LZfoMmqjDprDOksrmtvdzEXI1ItWbXbCV2i3QF56XrVb
 InHTUkoefwPiGKW4B2eLikcG8GH9wmtHQ9wHmFbnDmzRbMmNcJuhLpiCfsZ0bbT4D2RphU0xFct
 +RrDlnIPTIqBenRqypr5XIS5cbYSGgVVcF8M5t9jeyeiIeKbVM9hC9m+tJznbEJjfVvfBbWPLZf
 qnd+uVvj8ZIoUG9MDEDJx7nTME7m4Q9RWbn+69pq2B+V1M77HsyEMdoeCq/kdZR0JnDaX+ECAvO
 /vAsiWjgElVywF4QHyoLnZ
X-Received: by 2002:a17:903:2ac3:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2b2d5a77878mr269003585ad.39.1776358038866; 
 Thu, 16 Apr 2026 09:47:18 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b47810ae96sm78015315ad.21.2026.04.16.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:47:18 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 00:47:09 +0800
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <aeER8AIJZecuTLIc@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, 
 Jan Prusakowski <jprusakowski@google.com>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, 
 anand.jain@oracle.com, wqu@suse.com
References: <20260410131821.991005-1-jprusakowski@google.com>
 <ad3zThMKaWZ65XE2@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad3zThMKaWZ65XE2@infradead.org>
X-Headers-End: 1wDPsH-0002ZU-K7
Subject: Re: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal
 filesystem
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
Cc: wqu@suse.com, anand.jain@oracle.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 14, 2026 at 12:57:02AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 10, 2026 at 01:18:20PM +0000, Jan Prusakowski wrote:
> > F2FS uses a checkpoint mechanism for metadata consistency rather than a
> > traditional journal. Roll-forward recovery is only needed if there are
> > fsync'd files since the last checkpoint.
> > 
> > In this test case, files are created without fsync, so there is no
> > roll-forward data to replay during mount.
> > 
> > Therefore, F2FS does not need to write to the device to recover, and
> > successfully mounts on the read-only block device. Thus, it should be
> > treated as nojournal in this case.
> 
> This looks ok, but I always wonder if we want an opt-in for this
> "journaling" behavior and/or define it clear in common/.

_has_traditional_journal ? _has_journal_replay ? :-D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
