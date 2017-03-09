From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 4/4] f2fs: use __set{__claer}_bit_le
Date: Thu, 9 Mar 2017 18:38:42 +0800
Message-ID: <c732545a-80eb-6fcc-bf2a-0e0e1d5e4cf6@huawei.com>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
	<20170307221303.6757-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1clvUQ-0000uv-T4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 10:40:10 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clvUP-0005wJ-D4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 10:40:10 +0000
In-Reply-To: <20170307221303.6757-4-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/8 6:13, Jaegeuk Kim wrote:
> This patch uses __set{__clear}_bit_le for highter speed.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
