Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF0FC44501
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hcwtbI9a5wmR5nzdpM3qfVNlF5Y5nxbo2Q+0qMGS0Qw=; b=UW/tk/QrYoFeHBEzeNgaJCq1vr
	MudDhvBzJ/xKMG9LY2SvsiDmWvAO3LMfy7b0onpi69AkvsuYbrRYNDwKf5N2fiikcYtIj9DUv9Wvw
	lLmchtHHqKwiP6JteGqP1i8/5XWxxZrdf6VXqxX3lAwEcKddEv9DsdhY+gIsH3ekgAdU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiIlu-0007VQ-KZ;
	Fri, 10 Jul 2026 21:28:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wiIlt-0007VJ-BS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCdcaplzXS+st+F9pQrq95mwr9V9sUpfcWrc6HigFVQ=; b=HFMPPgHIhDcW6iEEjrXKxXqvG4
 uLXz1aTkqRcoxjdm/hPjyXXgriurWEwq0xARx9kWcw8CfqZ4vqm8J2ZY6regORUo5c/N48zMgS2C+
 DQidzoFsoxNwARde7q6MdwyQ1PuMaFlA1zX9iuBMCcMcF6XVi9xNHKru9bo5oOVxKEkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZCdcaplzXS+st+F9pQrq95mwr9V9sUpfcWrc6HigFVQ=; b=iVeGz3uwBiuu3vNxwsBAGExWVT
 cWfQbay5+PBbt9RJUWvHBzb8o7MQQtUfj4Dpmt0Gjoz7KPOA92vv5V+XzQ8XBgrCsxu8pIy5pgfXY
 rZojfwVsbXBA/YHN/RUX4xmL2LUaBnxQvZvvG3RSb3FdMZ+QfsXm9tYT7uUM2RLRl8tE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiIlt-0007RV-Fm for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:28:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DB8240ABA;
 Fri, 10 Jul 2026 21:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFF01F000E9;
 Fri, 10 Jul 2026 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783718903;
 bh=ZCdcaplzXS+st+F9pQrq95mwr9V9sUpfcWrc6HigFVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lKP4VFekqRrDXMUTynV25kuSERjqn9hJ9Ch0qp7i3OsmYvjVwp0Cgl5OBlQG0zDUV
 9HX29Cyg8gnEdC5tCHZxQHWINeS8H3WxYk/C91oaOM0P1m8zoOKuv2z8FeZgcKEFtp
 77vpCAn+8eTZ6KsoLUFqwjLhrxldcsj8sHOSpV7/zueTjxNXjALnzm0KavI4TV3ERI
 Ac6Bp0WfTi67wQ/AyI20TCSkg7zPnMtmzL6nmRecfZ7QAImIpfVd8L7eD4vaO3Gg0u
 mIbhaU4kKik5G5EQE1l6AnZ1u6y4Ir6Uc7cBcUuHBhfvzR1IOSj4U38l1NA/aZ5l1P
 CAybVm3D/zbTA==
Date: Fri, 10 Jul 2026 17:28:20 -0400
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260710212820.GC1911@quark>
References: <20260708011843.1036846-1-kbusch@meta.com>
 <20260709071352.GA20180@lst.de>
 <ak9f0CXSegLq8l5w@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ak9f0CXSegLq8l5w@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1wiIlt-0007RV-Fm
Subject: Re: [f2fs-dev] [PATCH] fs: report direct io constraints through
 file_getattr
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, brauner@kernel.org,
 jack@suse.cz, Keith Busch <kbusch@meta.com>, cem@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tytso@mit.edu, jaegeuk@kernel.org,
 Keith Busch <kbusch@kernel.org>, aalbersh@kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jul 09, 2026 at 10:51:39AM +0200, Andrey Albershteyn via Linux-f2fs-devel wrote:
> > Andrey, is there a man page or other official documentation for
> > file_setattr/file_getattr?
> 
> No, I had a draft in cover letter but haven't got to sending it to
> man-pages. I will prepare a man page.

Or just abandon this series, and read the statx(2) man page which
documents the already-existing UAPI for getting the DIO alignments?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
