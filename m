Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9A606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Vd9li64c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EBrRlHiv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T+HSNyA9;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SsNY7HU0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G8mVebMdzmVID5dZ6R8aGaRfEdIGZEkrkZMxZEPC6SY=; b=Vd9li64ceHT4cc
	QXpTjJKreWEtyxqszsHDwYHqu7JWKV4bVaMhhcaWeqnfq1eJSNRCc+SZVzoKCUNIfdj6UqUOuE7ZT
	Yh/Yo1YTtk4+0n6Be5zDKfbYMJLUoZDl4F9g06sEq35CXBIreZ4yFTVM2kQvnNVB8kxdw//oupgTA
	RVI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhiU-000000005r3-3VA5;
	Mon, 02 Nov 2026 02:24:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNhiM-000000005qF-2JZs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gz5AWrOwF+eMYz6dvsxu4Bgg5u11ePYMcl7sZ0k9G5Y=; b=EBrRlHivKK2u80X2J80G0SsOKN
 D2ZqTZmXKbWaSORAkyYy30dTN5UkILunjeAd0n4F7lc2C5gT+6npz3AxlFT9WfDAD7+7kdq9H2Pge
 kT72x9PKa9VW5lUMGorct9I0tfzVQ6YHFzHzTTeIA2zwYg4vmiM/kbem3hiEWop4tXtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gz5AWrOwF+eMYz6dvsxu4Bgg5u11ePYMcl7sZ0k9G5Y=; b=T+HSNyA9MTSpHzxpeMvmaa9WwA
 Ki9WNgv4RwuZR7p/TdFeSwe3gHxrY0y5xdqkP5aJurDDJNZUJ5FyKaNfcg77N6ER9aXOwKbA8kISn
 TZfEotypzpQHSHaRDNita1hlRJBPy6ImQqTXCVDP1VtxaMW+8hsH+gvPBggZTASu9PRA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNhiL-000000008TM-2z42
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:24:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C9B360098;
 Mon,  2 Nov 2026 02:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16551F0093A;
 Mon,  2 Nov 2026 02:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793586235;
 bh=gz5AWrOwF+eMYz6dvsxu4Bgg5u11ePYMcl7sZ0k9G5Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=SsNY7HU0g6zxYpVGBwA2RrD+kUjJSjedeTfWV27RiqyxDiW2TGOTnc+F7+loO/Cgu
 keOOTlI3tLPuIVeqU/Q+xUgpYB4DugV4PuVSvYjDErDzxVVJQSw1KbcysRddt0rq6V
 UVB3uf0Qfu9TLIRN8ZdE1p19ItDYHbt7003PjBAR+cX1PG/RXsF8vFPgjMycD4Webw
 nw6y9oQlNshWxPBE/oglSb5Z2B+ynuExcAOiqAgCXcozmK62/pi5dm8OQ90B7EP7cN
 VX1WuJq7iGxSjpSfOq2p6L2ID6rF7vZ2991Beo9KTDu63WS5H52ivmIhq1fwBz28sU
 xbcToWKGaY8ww==
Message-ID: <abdfe196-e847-4f11-8d1e-b53bc565a078@kernel.org>
Date: Mon, 2 Nov 2026 10:23:52 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hungyu Lin <dennylin0707@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261101230552.55034-1-dennylin0707@gmail.com>
Content-Language: en-US
In-Reply-To: <20261101230552.55034-1-dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNhiL-000000008TM-2z42
Subject: Re: [f2fs-dev] [PATCH] f2fs: report sub-block project quotas in
 statfs
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 07:05, Hungyu Lin wrote:
> f2fs_statfs_project() converts the selected block quota from bytes to
> filesystem blocks before checking whether a limit is set. A nonzero
> limit smaller than one filesystem block therefore becomes zero and
> skips the project block statistics.
> 
> For example, on a filesystem with 4 KiB blocks, setquota accepts a
> 1 KiB project hard limit, but df on the project-inherit directory
> reports the filesystem-wide capacity and free space instead of zero
> whole blocks. Quota enforcement still rejects a write that requires
> another data block.
> 
> Check the byte limit before converting it to blocks. This distinguishes
> a sub-block limit from an unlimited quota while retaining the existing
> rounding and free-space calculations.
> 

Cc: stable@vger.kernel.org

> Fixes: ddc34e328d06 ("f2fs: introduce f2fs_statfs_project")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
