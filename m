Return-Path: <SRS0=2ghP=WO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FEC3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Aug 2019 15:41:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33F4206DF;
	Sun, 18 Aug 2019 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LVdVCCbL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PNFuDKuJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqWTOmtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33F4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hzNJV-0003jq-6o; Sun, 18 Aug 2019 15:41:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hzNJT-0003jj-Pv
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 15:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUiJ6kdfa79eO22bMAi2QIjFM9AWXWzjEe3eaHOTHjA=; b=LVdVCCbLU6XHLenzejAI/iG/g/
 NkEgFNXiDeGe21gjOvJq+r7IZE0pc3N6k2hypLazRXls5EvB4RISm95hQM8vOPQtRahzCYb+5kh+h
 6Tff2pY7l6n4b2vKh4Voh2K940Mzl5v631g1yxLueXeAZy5HzWEzyGkW/rF28yj1Zupw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jUiJ6kdfa79eO22bMAi2QIjFM9AWXWzjEe3eaHOTHjA=; b=PNFuDKuJXWk+41+zCxHfZSnSby
 hWE/rb+aLCXyh8spqxwg+rOw9jnBrGyuSVWUiSoQyE7FD6YJ7huMhuranecoJV3pXjqpWaBDc4kNY
 tB9HF1duShZn3BJr+a/kep32tvc2TxMdoSsC4przS5ulB0QyRypNVP5qz2v9onmx+Nug=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hzNJR-007rQv-LU
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 15:41:47 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E042E206DF;
 Sun, 18 Aug 2019 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566142900;
 bh=uvnDPrjnSIpB0XZ7xCnFiRBuZWeL//9Wh0CIoFPfAa4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jqWTOmtw3m6CC8JfiKgbva4qBXNSB6lh5XOn10oARGjMEnhVcQg6mJMhu0k6faCYv
 6RNYqdOH5EtJzxQ7BF4iuvq9Mgb2qzRD9L42ehCdqRGHw6TmysztqUFsrHChYhX11o
 eKW4jM/yqH+u1/y6kFjubLIIMceShuXyZGc9g9uI=
Date: Sun, 18 Aug 2019 08:41:38 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190818154138.GA1118@sol.localdomain>
Mail-Followup-To: Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20190816055539.30420-1-ebiggers@kernel.org>
 <20190816055539.30420-3-ebiggers@kernel.org>
 <d6022f8b-2d75-4e9d-882e-038551684c37@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6022f8b-2d75-4e9d-882e-038551684c37@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Headers-End: 1hzNJR-007rQv-LU
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix copying too many bytes in
 FS_IOC_SETFSLABEL
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 16, 2019 at 02:59:37PM +0800, Chao Yu wrote:
> On 2019/8/16 13:55, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Userspace provides a null-terminated string, so don't assume that the
> > full FSLABEL_MAX bytes can always be copied.>
> > Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
> 
> It may only copy redundant zero bytes, and will not hit security issue, it
> doesn't look like a bug fix?
> 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Anyway, it makes sense to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 

It's not clear that userspace is guaranteed to provide a full FSLABEL_MAX bytes
in the buffer.  E.g. it could provide "foo\0" followed by an unmapped page.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
