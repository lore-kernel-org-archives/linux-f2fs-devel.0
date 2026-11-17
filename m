Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FE606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bi3RsoKa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ftiCNZoL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BXL4btY0;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GkgLJM/h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tMi7k4c3TjgDCHs2fHkczJSf6TRevYq05Z1/5CQApJY=; b=bi3RsoKaQTCLuE
	i7QM5u7C+wXCjlorkKXgOKNQLcifBC8r31mvuYcLim5qneoI4PnNxg5RfR9l8g9ioQZMgTlHwxJ53
	jCFusVXAg8+Fx80MY9dfwUoEfcFq0tOq1kXf9FoBwgpGV7Uhcwmt4csdFNQKh/eIJHo3ChRjfy//+
	FAo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTExd-0000000006C-1k7R;
	Tue, 17 Nov 2026 08:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTExc-0000000005D-28cc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EgHPyo8wPLK1o4zNxs+/XCVVqInnrzFjcZ18jP4kP8E=; b=ftiCNZoL/6M/LYiDpzx/DwmPxs
 cOHd330ZspmkkzLzXHwSS3M6p4B/VplEnIxIP1BYC7lv9EJyKRUN70aoI1+761RD6AAcn68t/yV26
 sCp0za+StZJR2zMQz8t86HQTOBYngkUxOCmasI2LDpGor43nJkcipX3EUH+cQBe5nQqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EgHPyo8wPLK1o4zNxs+/XCVVqInnrzFjcZ18jP4kP8E=; b=BXL4btY0lzKPm1nxgU3lgi7wBC
 TPUq7pUAVrZ/oFJrPiqHEjs0SaPTijH1iYWE8K+zBAxHndntZ+TxcP3ZpBPuq4JITOfXRG1aPC4kq
 qQ+VEDpec3Kl3l8TnH9ABp41STRBx0V8RSviQUHT4/+aVVISt47Zqwi8jo74GWj5QrmQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTExc-000000006jc-09uh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77816612BA;
 Tue, 17 Nov 2026 08:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243301F000C5;
 Tue, 17 Nov 2026 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905674;
 bh=EgHPyo8wPLK1o4zNxs+/XCVVqInnrzFjcZ18jP4kP8E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GkgLJM/hnEN5RZVQNRgzDZQLr0x4Yb9NgcjaYxyDVfo1CdK03B0CA9iL0MzX2n6Ji
 z1xaBqHfBfVTE2bLzi0Jv1xnh+zUDbdE0iomD4Sxgoh+4ziH6f275MERRS/oDtLrPX
 ER9anKzIgCynI9HDzo6KGw3O3fsqdpfqu30y0eedzMBd6hL7+/vbAWfQPt7VT6d2Vi
 R3yV3milttAYQA8YZuGjDWWWLxsIRF6btWFptZ7b2oqvYrq1e0MjX++7F7KWYO64ex
 D+yR5THrNO5iV23Vwgzr/HKRsHUb6dUeR58jAfm7VeGkueEciHg4BCN3vvm43SiAXS
 Xv0Z/FS5qhd5w==
Message-ID: <097ac698-f60d-4bd6-9936-a52e483ac656@kernel.org>
Date: Tue, 17 Nov 2026 16:54:30 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-5-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-5-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTExc-000000006jc-09uh
Subject: Re: [f2fs-dev] [PATCH v2 04/20] f2fs: support subpage blocks in
 directory operations
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a directory folio holds several dentry blocks.
> Address a dentry block within its folio by its block index, and mark
> only the modified dentry block dirty. When an empty dentry block is
> freed, clear only the state of that block and keep the folio dirty if
> other blocks in it are still dirty. If no dirty block is left, clear the
> gcing flag of the folio too.
> 
> Also read the name length in f2fs_delete_entry() under the folio lock,
> so that the dentry bitmap is not updated with a value read without it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
