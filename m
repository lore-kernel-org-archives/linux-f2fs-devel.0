Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F6606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=i8oKXqNe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EoHV4qhP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=foa/KL2M;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAR3oDje
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JUh2C9lIgSJgCZuTdt0RFCTJHvgk1WF7QIAw2BHgVqY=; b=i8oKXqNem9lglw
	q02a19sk8ijbut0695SRtevng29dmAMr9mgzlNPLI8O1CWWzB9FcfZnFnQYEKlSQa15UbXJj2eyyR
	uQWrUV0I61jdcsK88obH1MbgMJR/Zx7UfGeMCHRr/R1I4jzpcDvR5hD4+XwXg/8OavfqyMzJQ/Kp1
	TcI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJm1l-000000004CR-0t2a;
	Thu, 22 Oct 2026 06:11:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJm1k-000000004CL-2p0o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 06:11:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WB+qPHylD4j4YLw3dfH4zxL8YSpeWPdyUE/Y6qCaoeA=; b=EoHV4qhPxD2o9yUJeZvpIMGJ3x
 1olJa084Wvzha4hXtSYz2e7bJFpY+Y7SkIzriRxWJlUXDP2/VYlQZVTuROo7nW9WCjU7nhI6sKlMD
 jYptraDcBtT2rl+3q+yWeGKa11bTPXHLLk+1eJ9mPzDPLJAkHwxwRf91FOzcUAunYD+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WB+qPHylD4j4YLw3dfH4zxL8YSpeWPdyUE/Y6qCaoeA=; b=foa/KL2M8f3DS987aWzIIFoH+j
 gACyXiK5u/Hp9Xq3s2wyOZrGrypvnDXI3nJDZ7mz/Lb02LDcE3BYZOSEuiQM85wMNFpKfd+WrfxE7
 6LcGttpjWjuE1bBEXbcjCnHSchu2pC9FpKRMxxVbTe3bsi8zSwBseirJznAUg6VZorCM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJm1k-0000000026U-0usP
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 06:11:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DCBB60210;
 Thu, 22 Oct 2026 06:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37ED1F000C1;
 Thu, 22 Oct 2026 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792649502;
 bh=WB+qPHylD4j4YLw3dfH4zxL8YSpeWPdyUE/Y6qCaoeA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DAR3oDjeYYnkl5WzTnZmoojSq+2Q8wphcAsUPt4JIaH0r4Bhkh+P1kYmxSU2nn86i
 gKcAr9z87V12tj1BxkHqqfvqKPiJOVBJmPWjzMtugUCf7A8VhFRgpJGRTqO4v/ODF5
 GOpWlQOeE0zs2dZYjdawQiaETOwEE5oJwRDIvSqWYyxvCidcTgtGuyTLKbL0b/LoID
 qM0Ts7Xk5tKhJBIWj9LndTNtnEj5LuHb5RDasYmZSwam2avq3hBE/C2EhxUiEsxQKd
 yPgJKEIRNe/xZbJwP4BGqnTuVTGbbwVfC6F91N7n6TCWm2EWr6olFwSnqnZ0vpEz8g
 vkwgPy9KudvQg==
Message-ID: <9e529489-eff3-44fb-9e70-127971abf671@kernel.org>
Date: Thu, 22 Oct 2026 14:11:38 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
 <atD9Csw1-lj5_SR_@google.com> <atFFXafuVyyimmUk@google.com>
 <15373a26.1e3d.1a1494e8d1a.Coremail.nzzhao@126.com>
 <atY1gNfX9Lhg3zC6@google.com>
 <36f5c73d.3a87.1a162171418.Coremail.nzzhao@126.com>
Content-Language: en-US
In-Reply-To: <36f5c73d.3a87.1a162171418.Coremail.nzzhao@126.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJm1k-0000000026U-0usP
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 13:30, Nanzhe Zhao wrote:
>>
>> I'm testing the kernel on my primary phone. After applying the latest ones
>> again, I haven't hit the panic yet. So, could you please send v6? Then, I'll
>> reapply all and keep testing.
>>
> 
> I  have just fetched newest dev-test branch and dev branch, I see on dev-test branch
> you have already applied my v5 patches, so should I send a complete v6 patches
> to a different branch. or I send the changes to patch v5 on dev-test?
IMO, rebase v6 on dev should be fine.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
