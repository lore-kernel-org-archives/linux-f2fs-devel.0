Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F4C02182
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jan 2025 05:03:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tapMs-0002Sd-Sg;
	Thu, 23 Jan 2025 05:03:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kmjldy@loveyournewgreenhome.com>) id 1tapMp-0002SM-ON
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jan 2025 05:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Subject:To:From:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gJxkAyIn77PQOhX01r8TO2a4bj59KyM7DQFPjrIt45U=; b=U077HiKXIa7C3aiBT7nYKcG4A2
 ChSEYQ7yJidY/uwhjQdzc24KxypCZPi5r9n/AyjgL3Z0u/ypFbpm6TeuGHbWs3TWQi0dG9hEGPEjQ
 9LVjZu+reR+BFYUnpxIkzzDRy5xpVJimtJE+FUgqk5K+9CrkEaYm0yaH/yxYeWyBM60I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:From:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gJxkAyIn77PQOhX01r8TO2a4bj59KyM7DQFPjrIt45U=; b=h
 prod19Qp0bpYAMV0mkjbdzGWogy68qv+0/TFlSeEcw71y38ZZxD9BazS2OhmbFBs32Q0XSYQROLnC
 BU5fSrNdbTzPbO3KjIooHjYESyoVR/4Ng4ftzvkmM6WhMXL23IqYTwv2VCC3uMtLRQT27vInuaBxu
 fVYC4L5Z+0WdolSc=;
Received: from v157-7-142-223.myvps.jp ([157.7.142.223]
 helo=loveyournewgreenhome.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tapMo-0003bR-1l for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jan 2025 05:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default;
 d=loveyournewgreenhome.com; 
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=kmjldy@loveyournewgreenhome.com;
 bh=gJxkAyIn77PQOhX01r8TO2a4bj59KyM7DQFPjrIt45U=;
 b=wPzrcUN57YiTDzm7f3v+2lzX5pHVjmn4D72/v8Q9y+sfV3PjzZmt3Ax3nkZ1AqeaFFxDEhAggjhL
 iUYqCy64pvHoiLfrVWvabrJMJTNLlgB2FlOcPKm2+5CDiYg8Lbp45ndPc+Vqw+ME3HuZBzDhXWdi
 OuFrCkEw39QEDkNTGKU=
Message-ID: <9718e6eb626bb6b4578635d935542f40@loveyournewgreenhome.com>
From: "ゴールドポイントカード・プラス" <kmjldy@loveyournewgreenhome.com>
To: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Date: Thu, 23 Jan 2025 12:42:25 +0800
MIME-Version: 1.0
X-Headers-End: 1tapMo-0003bR-1l
Subject: =?iso-8859-1?q?_=5Bf2fs-dev=5D_=1B=24B!Z=3F7=3DU=3DiGd!=5B=254!?=
 =?iso-8859-1?q?=3C=25k=25I=25=5D=25=24=25s=25H=25+!=3C=25I!=26=25W=25i=25?=
 =?iso-8859-1?q?92q0wMM8BDj!*=1B=28B10=2C000=1B=24B1=5F=25-=25c=25C=257=25?=
 =?iso-8859-1?q?e=25P=25C=25/!*=1B=28B?=
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


いつも ゴールドポイントカード・プラスをご利用いただき、誠にありがとうございます。

━━━━━━━━━━━━━━━━━━━━
★ ゴールドポイントカード・プラス会員様限定 特別キャンペーン ★
━━━━━━━━━━━━━━━━━━━━

2024年1月以降にヨドバシ.comをご利用いただいたお客様、
またはゴールドポイントカード・プラスを2回以上ご利用いただいたお客様に、
最大10,000円キャッシュバックがもらえるキャンペーン実施中。この素晴らしい特典をお見逃しなく！


▼ 今すぐキャッシュバック特典を手に入れましょう

https://goldpoint-co-jp.ycuxione.com/?apply=07kwokz9hh40YE3QXKJWh4gCZs29P0

■ 特典内容：
〇 特別に進呈するポイント（1万円相当）
〇 利用可能シーン：本カード会員様のお引落し口座へご返金
※その他のご利用代金がある場合は相殺となります。
―――
■ ご注意事項：
―――
以下の場合はキャンペーンポイント還元の対象外となります

〇カードご利用代金のお支払いを遅滞された場合(支払期日未到来分を除く)
〇特典ポイント還元時点で対象カードを解約（カード会員資格の喪失を含む）されている場合


────────────────────
＜お問い合わせ＞

株式会社ゴールドポイントマーケティング
〒160-8486
東京都新宿区新宿5丁目3番1号
0570-06-7070（固定電話3分/8.5円　携帯電話20秒/10円）
営業時間: 月-土 9:00-17:00（日・祝日・年末年始は休業）
────────────────────



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
