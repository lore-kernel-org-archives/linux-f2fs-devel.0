From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: no need to create issue_discard_thread
 if it exists
Date: Fri, 7 Jul 2017 10:02:10 +0800
Message-ID: <595EEBA2.8070406@huawei.com>
References: <1499339134-104480-1-git-send-email-yunlong.song@huawei.com>
	<c76a5045-078b-1018-23f8-ccfaefa6f2b4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yunlong.song@huawei.com>) id 1dTIbv-0007dt-2A
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 02:03:11 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dTIbt-0002gk-J5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 02:03:11 +0000
In-Reply-To: <c76a5045-078b-1018-23f8-ccfaefa6f2b4@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, sylinux@163.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It's fine unless create_discard_cmd_control is used in remount flow in the future.

On 2017/7/6 21:16, Chao Yu wrote:
> Hi Yunlong,
>
> It looks there is no way to create discard thread redundantly,
> so here we don't need to check this?
>
> Thanks,
>
> On 2017/7/6 19:05, Yunlong Song wrote:
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>  fs/f2fs/segment.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 4c246e3..b48d004 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1417,6 +1417,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>  
>>  	if (SM_I(sbi)->dcc_info) {
>>  		dcc = SM_I(sbi)->dcc_info;
>> +		if (dcc->f2fs_issue_discard)
>> +			return err;
>>  		goto init_thread;
>>  	}
>>  
>>
> .
>


-- 
Thanks,
Yunlong Song



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
