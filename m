From: cgxu519 <cgxu519@gmx.com>
Subject: mount fail with option fault_injection < 20000 && >0
Date: Tue, 18 Sep 2018 19:02:27 +0800
Message-ID: <61afbde5-f05e-9bd5-8dc2-31932c13cd51@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g2DmJ-0006Ew-1w
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 11:02:47 +0000
Received: from mout.gmx.net ([212.227.17.20])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g2DmH-004r2v-4h
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Sep 2018 11:02:46 +0000
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

HI guys,

I found mount with option fault_injection < 20000 && >0 will fail with 
error -ENOMEM.
I understand fault_injection function is explicitly mocking some errors, 
but isn't it better
mocking errors after successful mount? Is it really allocating memory so 
many times
during mount process?

Thanks,
Chengguang
