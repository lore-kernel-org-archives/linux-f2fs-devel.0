From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [4.9-stable] Revert "f2fs: do not recover from previous remained
 wrong dnodes"
Date: Thu, 17 Jan 2019 19:31:14 +0000
Message-ID: <1547753474.3229.184.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This fix went into 4.10 and looks like it is needed for the 4.9-stable
branch:

commit d47b8715953ad0cf82bb0a9d30d7b11d83bc9c11
Author: Chao Yu <yuchao0@huawei.com>
Date:   Sat Nov 5 11:12:40 2016 +0800

    Revert "f2fs: do not recover from previous remained wrong dnodes"

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
