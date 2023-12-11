Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F70C10F09
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Dec 2023 09:26:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rCcYg-00050Q-IM;
	Mon, 11 Dec 2023 09:26:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <smsmailapp03@lviv.ukraine.berkospecial.com>)
 id 1rCcYe-00050H-Ol for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Dec 2023 09:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klstDcbTR6u2IpKariUn9rJJ+CyqYI4+jQQ51sH1INc=; b=BNa8w58TKcBacapG105XVjag17
 zhmUCWtoMVdmGNOowXV502ijeC6TffpCX98fqEJT54cP5IEhRJ9xfZi3XEqUws0zmHpf4bM+hKBmt
 NbiyZ4TrEC1NmaREQjEjyn1CUdDg1K9FeDTn8gpnyOvqibJX+ukCMTSRxbZTtzSeD9SE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=klstDcbTR6u2IpKariUn9rJJ+CyqYI4+jQQ51sH1INc=; b=g
 VhxqSu8vPx2tTb9NbAwkKmkUnqwvpnDv0hJyg3juIuFYdnkqoURjK0uzkDTVQf89l6zFqvR7xRNx6
 0aSvW04Ct+l0NWr7NFbUXuK1zrHN9qI64t0FVIWUlc6ecDqBnulheUeIhmUzyh1kWR0jnQq/EZBJw
 dz+d/pb6PWqpbR7Y=;
Received: from mx.lviv.ukraine.berkospecial.com ([209.141.37.105])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rCcYb-0001s0-Ep for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Dec 2023 09:26:37 +0000
Received: from lviv.ukraine.berkospecial.com (whcm.berkospecial.com
 [209.141.48.157])
 by mx.lviv.ukraine.berkospecial.com (Postfix) with ESMTPA id 366E16550
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Dec 2023 09:26:18 +0000 (UTC)
To: linux-f2fs-devel@lists.sourceforge.net
Date: 11 Dec 2023 09:26:14 -0800
Message-ID: <20231211092456.0C622D19C0E93EB8@lviv.ukraine.berkospecial.com>
MIME-Version: 1.0
X-Headers-End: 1rCcYb-0001s0-Ep
Subject: Re: [f2fs-dev] Dear Respectable,
 I awaits for your response to my message!!!
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
From: "E. Petrova via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: evanpet@ukraine.bakhmut.wheatexporters.shop
Cc: "E. Petrova" <smsmailapp03@lviv.ukraine.berkospecial.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

My name is Evan from Ukraine.I have tried to reach you but find 
it difficult due to internet scarcity here in this town.
I am contacting you because I want to flee Ukraine and come over 
to you country,I have some funds I plan to invest in your country 
because I want to relocate my Late Father business due to ongoing 
war in my country Ukraine and visit your country to set up new 
investment business you may advice profitable in your area.
I also have some millions of dollars i want to invest and 995kg 
of 24carat gold I want to ship to your country and establish gold 
jewelry manufacturing company.
I will offer you good monetary rewards for your help,due to how 
russian drone boambards this town frequently,phone network is 
disrupted because of attacks on network installations,please for 
fast discussion, you can add me on whats up and let's talk,this 
is my whatsapp number below
whatsapp:+380-97-296-2302
Thanking you as i wait to hear from you soon so i can tell you 
more details.
God bless you for your care.
 
Regards,
Evan.
whatsapp:+380-97-296-2302


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
