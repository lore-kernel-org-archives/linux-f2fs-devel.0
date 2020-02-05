Return-Path: <SRS0=KF8H=3Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE00C35247
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:40:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FED820730
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="FvChcne9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X1Pco57R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hs0KxLcI";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="Eucncfy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FED820730
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZxJrSxpNLmjrhGrB/JG6hvF1XyNbE+0WzlO3GDiqFc=; b=FvChcne9NWbEA3giBt+ygrFPgB
	LRkiYpvUhYgFWMhy0huxSZ7hcyfBw5wsgm7YWyucBDo184dEBxBlexlNUIreggoBguc1pgZbPcAhQ
	NCUtJGcOPgfHGc4wFmZ5uKbOAKU0K5tCltXcqz4TIGDeMMMj+B/3eoakUUCN2kucQc50=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1izUHc-0000vt-BH; Wed, 05 Feb 2020 23:40:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <drosen@google.com>) id 1izUHa-0000ve-SR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 23:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eImnorc+E72Ebn4XEF1SUg6cxpdpF8frzXw7k6RoRcE=; b=X1Pco57RHw0oQTWyTUhaCSwWlm
 T0P8zIjYdL7pZsI4hr2cUX9SAcKMqiHIyLXTRlUdVEKDHFTDB0WyjhZexRuhMn+7OAbVfSw/nb1xb
 9Lut8Uteno8It/VszDALZHpOI9NfxTOQS+uiigguvVXKsa5O60et4Zxn6LhapxoQtfAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eImnorc+E72Ebn4XEF1SUg6cxpdpF8frzXw7k6RoRcE=; b=hs0KxLcIIYuPVB6ycRGljCTTzP
 2HTg4Vli2g14MF5xErV4OO4YWgFIf3lpP6C2ue043ghdYGpjRSauoTA0mpjmCAz9IKUoRnQbb/rJ1
 A+BjEhQrxqyFYoANlJXSPIct2pcCvheJ3HJOPLL1chDXunLL4uqrRQsrhxDXhwcQoV3I=;
Received: from mail-lf1-f67.google.com ([209.85.167.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1izUHX-00BOXf-3g
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 23:40:34 +0000
Received: by mail-lf1-f67.google.com with SMTP id r14so2770002lfm.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Feb 2020 15:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eImnorc+E72Ebn4XEF1SUg6cxpdpF8frzXw7k6RoRcE=;
 b=Eucncfy0bfw2XSNvy3spLaCcbAJQXGXLfKwBFip2IDIQLXmUo0Oshd2FbgLS3FZnZK
 9niWI9xMAjS7AulP2kZjWHny2XgDM4S//hdCeWXKGIFCEUzBUo9M1OOddK2Eg26bMsyB
 DveOA8IJDdhnBk9uzpiAv8bDzUzDwCELfF16cn3TKe90OqY8nddNTeRzv5gtlrc0uFPh
 ptbM+AfLEnnLiVD9BHUxlxFOKknvZ/WKsce5pwcjNl6ABhJJ2svy6h+x4B1RvPJIsTC1
 B661E2LWjz74WjBpodNkt6YPeBFT46XbVetSnJ+7xHdI0sIyKm27coJnchHIyhuRidtM
 TUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eImnorc+E72Ebn4XEF1SUg6cxpdpF8frzXw7k6RoRcE=;
 b=hONAbia3eLg6TCC9DgDXFc9Cpn5WHK6qqgwg1QBUNJF+G9hsdPTZT1RtBJ1LvX3Q+q
 WDauXD/q2wK+qbpVIvqdSCgWROQdYG8KEjdsv7KqSvNSLgO2hcife/pRuaJ84jdbPccz
 Ecbl+mDeqsGFconP+QZah68zmZD9gAd3HH7nj7etiiKw+QmMjquCJacFu3nU9/hq4sCb
 /jjiVrj5NnwtBsO9FwZ9HurR5vSBru0yj+uiqCt/6tlv02rEBUMibTBbAsPKSbt4maaM
 eX/zhlmyaJKYhkCnPhtLHG+ucZ1yLYAqMgoOepKwLCxiFMNE0KAFO+nVFtMjZmvH7GI4
 DdXQ==
X-Gm-Message-State: APjAAAW3oBE+dAvb0kYW4YDCz2c8V+KwIOQ6aRtsK8VTKpIvbn87omK1
 C8c9CVUUshcyVr2qCLpEGa+gVhsQSStMknHmyGQG5Q==
X-Google-Smtp-Source: APXvYqzzEBWngyKstrRaijt7X7I5bXY9Val+Hxs5gu/BwpxZpiBbhMGiFic8G5pM6rS0i/mpmGgwfAohfvUcJsRyKVQ=
X-Received: by 2002:ac2:5979:: with SMTP id h25mr122207lfp.203.1580946023798; 
 Wed, 05 Feb 2020 15:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20200128230328.183524-1-drosen@google.com>
 <20200128230328.183524-2-drosen@google.com>
 <85sgjsxx2g.fsf@collabora.com>
 <CA+PiJmS3kbK8220QaccP5jJ7dSf4xv3UrStQvLskAtCN+=vG_A@mail.gmail.com>
 <85h8051x6a.fsf@collabora.com>
In-Reply-To: <85h8051x6a.fsf@collabora.com>
Date: Wed, 5 Feb 2020 15:40:11 -0800
Message-ID: <CA+PiJmQgFNLYoRu7fSWgz_He8Z8ceq1G2yUDcy0OCn1iD2rkzA@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Headers-End: 1izUHX-00BOXf-3g
Subject: Re: [f2fs-dev] [PATCH v6 1/5] unicode: Add standard casefolded d_ops
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 Richard Weinberger <richard@nod.at>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 4, 2020 at 8:21 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Daniel Rosenberg <drosen@google.com> writes:
>
> Hi,
>
> It was designed to be an internal thing, but I'm ok with exposing it.
>
> --
> Gabriel Krisman Bertazi

We could also avoid exposing it by creating an iterator function that
accepts a context struct with some actor function pointer, similar to
iterate_dir. I'm currently reworking around that and moving the fs
specific functions to libfs. I can move the generic op_set code there
as well.

-Daniel Rosenberg


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
