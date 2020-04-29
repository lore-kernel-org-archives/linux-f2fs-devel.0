Return-Path: <SRS0=XYej=6N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA7C83000
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:41:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099B2206B8;
	Wed, 29 Apr 2020 15:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fqtXm5j2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="G7xmQwNT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9AfLiaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099B2206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jToq3-0002rd-Kc; Wed, 29 Apr 2020 15:41:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jToq2-0002rS-Dg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Apr 2020 15:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PLyjb0w5CzmHJXNuF/Uoorc3+a06ovlRmmI7Js/91gQ=; b=fqtXm5j2zlMNqF48Xgpb1L59Qr
 bmim+8dn1zIbuQo0bmRhrMtnjx0yLirc+a7op4w6+tNUUzkA9vN7q270uFpCbb/JYudBp9Z25u+Tq
 TQChlDxkGnM/YAPUzCiBw+NlX30QWl/sKphZ84pPafk7D71uC9gdQV89WfJy3VFcxRtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PLyjb0w5CzmHJXNuF/Uoorc3+a06ovlRmmI7Js/91gQ=; b=G7xmQwNTBmllwxkrSl8yJhCH71
 Fea1XkcRz2oNCoOBjgz73IJX3C3dEDSf9zOgBiy5rS1nx9q1Bx7wrbOenLBCpWAHwTmGzKdQleHqI
 5ibSwmEyzsdZBZ6twmAZu6dMrKwEsMHAKR/jzB6GXVWI4cKhfvhc7bGEUU/MEAjF6nzQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jTopv-00GMPa-Jc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 29 Apr 2020 15:41:30 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6E6C206B8;
 Wed, 29 Apr 2020 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588174878;
 bh=2ZqWRbxVt4j71SLYV4KPEQCs1PbuDAjO7HUknYYbNns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R9AfLiaFJlw5JSXlCW15G3DTabSmVOQ/lANj0JENNj4+UeE02Y92/rNK/YKukolZD
 1W1RnOWmMUpOyf8cN8cRPMrfsX6imrbanS7UnYVA6dLa1vpNwdI2un/EBsqL0bUOe5
 XtPi1ATfXhEh3BndFU++e7RrogPF0GEBcwXuQUlg=
Date: Wed, 29 Apr 2020 08:41:16 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200429154116.GA1844@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-1-satyat@google.com>
X-Headers-End: 1jTopv-00GMPa-Jc
Subject: Re: [f2fs-dev] [PATCH v11 00/12] Inline Encryption Support
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

On Wed, Apr 29, 2020 at 07:21:09AM +0000, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> UFS, fscrypt, f2fs and ext4.
> 

This patch series can also be retrieved from

        Repo: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
        Tag: inline-encryption-v11

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
