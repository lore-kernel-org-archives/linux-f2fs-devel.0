Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B305C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 24 Jul 2022 10:24:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oFYn0-00038h-Dm; Sun, 24 Jul 2022 10:24:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oFYmz-00038a-BS
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 10:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mCJ8O6n718CaqNanEcifkxPmShDkLn7eu59EfCxEUqY=; b=MnykhY6aT6qax3Ke+kSXhF+3s8
 yTDjo/UZQofse94j3lMOjapFrNnkVa1VAq87ys+r4Ves7pjWc2iEmKGnbFVKOJOyUL0R5T9otuGhW
 e96DaKteU1FLdujyRaBlQIjHOBd+AhcXUJGcS27Zph7PRc9djXbnIDtF/Z1S5KmrsxnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mCJ8O6n718CaqNanEcifkxPmShDkLn7eu59EfCxEUqY=; b=HbJYkpCeMyGycKIuOIVWsMR950
 oa5OFNf+w6rMq79cda3jDOMfoptwZX2BLiyCH3yEmu04jXoNzTb+PdQyR/+Mge119RZlnawtdxagn
 1gkbZhoJta3O9AJ368zPDvJZbu/iJIcJOd3ltx+WcaXOokB+N1vg0BmMZUy1SagDTGYc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oFYmx-0006SX-7C
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 10:24:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7AFECCE0FE3;
 Sun, 24 Jul 2022 10:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B23C3411E;
 Sun, 24 Jul 2022 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658658270;
 bh=5DOYKUlvLL6Z7uuzGBjXxGmpXeL6qIJ3XVc6PX9tsnk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Raxrsc+7mEDMv1BPbOuxpY1ikf40AGeqxzLOhCWKvMRfAeMNYYjCWwom7iCE6HYge
 yCeIuerQeACmZThQiy8QO7C1Uc1K6S1DQnJKcHbcCRfNAsmQWl2ItUMj692FYX0JEa
 WidPt1v+r9lgWif+qvaLagiOUmI67i6js3d11NsoSGo2qeEB6PSWCrmKM4zVORhs89
 41YKv+IxoTnpyWgX1YQkewyqyudCpDdhCboRL2JouQs8evZzWrGQQ3Dyvhnr7Saovm
 m5QmSUKHSmWhWrFnoSYKPFxtjO/Ii4pwW5p58p1lMcnR46IJH6LeHUFUjC1TXtadei
 Ntz/HYtxJ0PWQ==
Message-ID: <722deaed-6595-f6e8-b7d3-348a94719620@kernel.org>
Date: Sun, 24 Jul 2022 18:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20220620173843.1462198-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220620173843.1462198-1-daeho43@gmail.com>
X-Headers-End: 1oFYmx-0006SX-7C
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: introduce memory mode
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/21 1:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Introduce memory mode to supports "normal" and "low" memory modes.
> "low" mode is to support low memory devices. Because of the nature of
> low memory devices, in this mode, f2fs will try to save memory sometimes
> by sacrificing performance. "normal" mode is the default mode and same
> as before.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
